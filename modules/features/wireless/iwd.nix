{ ... }: {
  flake.nixosModules.iwd = { ... }: {
    networking.networkmanager.enable = false;

    networking.wireless.iwd = {
      enable = true;
      settings = {
        General = {
          AddressRandomization = "network";
        };
        Network = {
          EnableNetworkConfiguration = true;
        };
      };
    };
  };
}
