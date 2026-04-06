{ ... }: {
  flake.nixosModules.cups = { pkgs, ... }: {
    services.printing.enable = true;
  };
}
