{ ... }: {
  flake.nixosModules.obs = { config, lib, pkgs, ... }:
    let
      cudaEnabled = lib.attrByPath [ "local" "nvidia" "cuda" "enable" ] false config;
    in {
      options.local.environment.packages.obs = lib.mkOption {
        type = lib.types.package;
        readOnly = true;
        description = "Resolved OBS Studio package for this host.";
      };

      config.local.environment.packages.obs =
        if cudaEnabled then
          pkgs.obs-studio.override { cudaSupport = true; }
        else
          pkgs.obs-studio;
    };
}
