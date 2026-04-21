{ inputs, ... }: {
  flake.nixosModules.nautilus = { config, lib, pkgs, ... }: {
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

    services.gvfs.enable = true;
    services.udisks2.enable = true;
  };
}
