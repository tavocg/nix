{ ... }: {
  flake.nixosModules.storage = { ... }: {
    services.udisks2.enable = true;
  };
}
