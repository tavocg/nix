{ inputs, ... }: {
  flake.nixosModules.systemDigitalSignature =
    { config, pkgs, ... }:
    let
      fdcr = inputs.fdcr.packages.${pkgs.stdenv.hostPlatform.system};
      # FDCR snapshots use a separate, pinned nixpkgs. Replace their launcher's
      # runtime with our patched JDK, retaining the snapshot's build JDK.
      withJava =
        jdk: package:
        package.overrideAttrs (old: {
          postInstall = (old.postInstall or "") + ''
            launcher="$out/bin/${old.pname}"
            if [ -f "$out/bin/.${old.pname}-wrapped" ]; then
              launcher="$out/bin/.${old.pname}-wrapped"
            fi
            substituteInPlace "$launcher" \
              --replace-fail '${old.env.JAVA_HOME}/bin/java' '${jdk}/bin/java'
          '';
        });
    in
    {
      imports = [ inputs.fdcr.nixosModules.default ];

      services.fdcr = {
        enable = true;
        middleware.enable = true;
        scmanager = {
          enable = true;
          nautilus.enable = true;
        };
        # gaudi.enable = true; # Does not work on nix because of auto-update, fix later.
        certificates.enable = true;
      };

      environment.systemPackages = [
        config.services.fdcr.package

        (withJava pkgs.jdk21Xdg (
          fdcr.firmador.override {
            pkcs11Module = "${config.services.fdcr.package}/lib/SCMiddleware/libidop11.so";
          }
        ))

        (withJava pkgs.jdk25Xdg (
          fdcr.firmador-git.override {
            pkcs11Module = "${config.services.fdcr.package}/lib/SCMiddleware/libidop11.so";
          }
        ))
      ];
    };
}
