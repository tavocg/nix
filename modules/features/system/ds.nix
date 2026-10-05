{ ... }: {
  flake.nixosModules.systemDigitalSignature = { ... }: {
    services.pcscd.enable = true;
  };
}

