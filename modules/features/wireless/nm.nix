{ ... }: {
  flake.nixosModules.nm = { pkgs, ... }: {
    networking.networkmanager.enable = true;
  };
}

