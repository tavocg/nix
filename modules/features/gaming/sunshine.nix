{ inputs, ... }: {
  flake.nixosModules.gamingSunshine =
    {
      config,
      lib,
      pkgs,
      utils,
      ...
    }:
    let
      cudaEnabled = lib.attrByPath [ "local" "gpu" "nvidia" "cuda" "enable" ] false config;
      cudaPackages = lib.attrByPath [ "local" "gpu" "nvidia" "cuda" "packages" ] pkgs.cudaPackages config;
      sunshineDotfilesDir = inputs.dotfiles + "/sunshine";
      sunshineAppsSource = sunshineDotfilesDir + "/apps.json";
      sunshineAppsFile = pkgs.writeText "apps.json" (builtins.readFile sunshineAppsSource);
      sunshineConfigFile = pkgs.writeText "sunshine.conf" (
        builtins.replaceStrings [ "file_apps = apps.json" ] [ "file_apps = ${sunshineAppsFile}" ] (
          builtins.readFile (sunshineDotfilesDir + "/sunshine.conf")
        )
      );
      sunshinePackage =
        (
          if cudaEnabled then
            pkgs.sunshine.override {
              cudaSupport = true;
              inherit cudaPackages;
            }
          else
            pkgs.sunshine
        ).overrideAttrs
          (old: {
            # Sunshine uses std::ranges::to (C++23), which is missing from the GCC
            # 13 libstdc++ that ships with the pinned CUDA 12.6 package set (used
            # for Pascal GPUs). Patch the single debug-log use so it builds there.
            patches = (old.patches or [ ]) ++ [ ./sunshine-ranges-to.patch ];
          });
    in
    {
      config = lib.mkMerge [
        {
          hardware.uinput.enable = true;

          services.sunshine = {
            enable = true;
            openFirewall = true;
            package = sunshinePackage;
            autoStart = true;
          };

          systemd.user.services.sunshine.serviceConfig.ExecStart = lib.mkForce (
            utils.escapeSystemdExecArgs [
              (lib.getExe config.services.sunshine.package)
              "${sunshineConfigFile}"
            ]
          );
        }
        (lib.mkIf config.local.user.enable {
          users.users.${config.local.user.name}.extraGroups = lib.mkAfter [ "uinput" ];
        })
      ];
    };
}
