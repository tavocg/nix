{ inputs, ... }: {
  flake.nixosModules.systemDigitalSignature = { pkgs, ... }:
  let
    fdcr = inputs.fdcr.packages.${pkgs.stdenv.hostPlatform.system};
  in {
    services.pcscd.enable = true;

    environment.systemPackages = [
      fdcr.fdcr-middleware-idopte
      (fdcr.firmador.override {
        pkcs11Module = "${fdcr.fdcr-middleware-idopte}/lib/SCMiddleware/libidop11.so";
      })
    ];
  };
}
