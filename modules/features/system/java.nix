{ self, ... }: {
  flake.overlays.openjdkXdgCache =
    final: prev:
    let
      patchFontCache =
        jdk:
        jdk.overrideAttrs (old: {
          patches = (old.patches or [ ]) ++ [ ./java/font-cache-xdg.patch ];
        });
    in
    {
      openjdk21 = patchFontCache prev.openjdk21;
      openjdk25 = patchFontCache prev.openjdk25;
      openjdk21_headless = patchFontCache prev.openjdk21_headless;
      openjdk25_headless = patchFontCache prev.openjdk25_headless;
    };

  flake.nixosModules.systemJava = { ... }: {
    nixpkgs.overlays = [ self.overlays.openjdkXdgCache ];
  };
}
