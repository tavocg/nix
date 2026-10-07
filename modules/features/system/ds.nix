{ inputs, ... }: {
  flake.nixosModules.systemDigitalSignature = { config, pkgs, ... }:
  let
    fdcr = inputs.fdcr.packages.${pkgs.stdenv.hostPlatform.system};
  in {
    imports = [ inputs.fdcr.nixosModules.default ];

    services.fdcr = {
      enable = true;
      scmanager = {
        enable = true;
        nautilus.enable = true;
      };
    };

    environment.systemPackages = [
      config.services.fdcr.package

      (fdcr.firmador.override {
        pkcs11Module = "${config.services.fdcr.package}/lib/SCMiddleware/libidop11.so";
      })
    ];
  };
}
