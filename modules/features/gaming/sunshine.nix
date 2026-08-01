{ inputs, ... }: {
  flake.nixosModules.gamingSunshine =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      cudaEnabled = lib.attrByPath [ "local" "nvidia" "cuda" "enable" ] false config;
      sunshineDotfilesDir = inputs.dotfiles + "/sunshine";
      sunshineConfigFile = pkgs.writeText "sunshine.conf" (
        builtins.readFile (sunshineDotfilesDir + "/sunshine.conf")
      );
      sunshineAppsFile = pkgs.writeText "apps.json" (
        builtins.readFile (sunshineDotfilesDir + "/apps.json")
      );
      sunshinePackage =
        if cudaEnabled then
          pkgs.sunshine.override {
            cudaSupport = true;
            cudaPackages = pkgs.cudaPackages;
          }
        else
          pkgs.sunshine;
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
        }
        (lib.mkIf config.local.user.enable {
          users.users.${config.local.user.name}.extraGroups = lib.mkAfter [ "uinput" ];

          systemd.tmpfiles.rules = [
            "d /home/${config.local.user.name}/.config/sunshine 0755 ${config.local.user.name} users - -"
            "L+ /home/${config.local.user.name}/.config/sunshine/sunshine.conf - - - - ${sunshineConfigFile}"
            "L+ /home/${config.local.user.name}/.config/sunshine/apps.json - - - - ${sunshineAppsFile}"
          ];
        })
      ];
    };
}
