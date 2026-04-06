{ ... }: {
  flake.nixosModules.wifi = { pkgs, ... }: {
    networking.networkmanager.enable = true;
  };
}

