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
      # Keep build dependencies unchanged so unrelated packages retain their
      # binary cache paths. Opt into the patched JDK only at runtime.
      jdk21Xdg = patchFontCache prev.jdk21;
      jdk25Xdg = patchFontCache prev.jdk25;
    };

  flake.nixosModules.systemJava = { ... }: {
    nixpkgs.overlays = [ self.overlays.openjdkXdgCache ];
  };
}
