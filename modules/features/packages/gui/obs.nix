{ ... }: {
  flake.nixosModules.packagesGUIOBS = { config, lib, pkgs, ... }:
    let
      cudaEnabled = lib.attrByPath [ "local" "gpu" "nvidia" "cuda" "enable" ] false config;
    in {
      options.local.packages.obs = lib.mkOption {
        type = lib.types.package;
        readOnly = true;
        description = "Resolved OBS Studio package for this host.";
      };

      config.local.packages.obs =
        if cudaEnabled then
          pkgs.obs-studio.override { cudaSupport = true; }
        else
          pkgs.obs-studio;
    };
}
