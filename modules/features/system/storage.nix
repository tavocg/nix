{ ... }: {
  flake.nixosModules.systemStorage = { ... }: {
    services.udisks2.enable = true;
  };
}
