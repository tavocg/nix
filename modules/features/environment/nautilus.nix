{ ... }: {
  flake.nixosModules.nautilus = { lib, pkgs, ... }: {
      options.local.environment.packages.nautilus = lib.mkOption {
        type = lib.types.package;
        readOnly = true;
        description = "Resolved Nautilus package for this host.";
      };

      nixpkgs.overlays = [
        (final: prev: {
          nautilus = prev.nautilus.overrideAttrs (nprev: {
            buildInputs =
              nprev.buildInputs
              ++ (with pkgs.gst_all_1; [
                gst-plugins-good
                gst-plugins-bad
              ]);
          });
        })
      ];

      config.local.environment.packages.nautilus = pkgs.nautilus;
      config.environment.pathsToLink = [ "share/thumbnailers" ];

      config.services.gvfs.enable = true;
      config.services.udisks2.enable = true;
    };
}
