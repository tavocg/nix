{ ... }: {
  flake.nixosModules.storage = { pkgs, ... }: {
    services.udisks2.enable = true;
    services.gvfs.enable = true;
  };
}
