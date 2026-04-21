{ ... }: {
  flake.nixosModules.nautilus = { lib, pkgs, ... }: {
    options.local.environment.packages.nautilus = lib.mkOption {
      type = lib.types.package;
      readOnly = true;
      description = "Resolved Nautilus package for this host.";
    };

    config = {
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

      local.environment.packages.nautilus = pkgs.nautilus;
      environment.pathsToLink = [ "share/thumbnailers" ];

      services.gvfs.enable = true;
      services.udisks2.enable = true;
    };
  };
}
