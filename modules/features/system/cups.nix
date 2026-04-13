{ ... }: {
  flake.nixosModules.cups = { ... }: {
    services.printing.enable = true;
  };
}
