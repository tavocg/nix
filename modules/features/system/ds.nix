{ inputs, ... }: {
  flake.nixosModules.systemDigitalSignature = { pkgs, ... }: {
    services.pcscd.enable = true;

    environment.systemPackages = [
      inputs.fdcr-repo.packages.${pkgs.stdenv.hostPlatform.system}.fdcr-middleware-idopte
    ];
  };
}
