{ ... }: {
  flake.nixosModules.networkManagerIWD = { ... }: {
    networking.dhcpcd.enable = false;
    networking.networkmanager.enable = true;
    networking.networkmanager.wifi.backend = "iwd";
    services.resolved.enable = true;

    networking.wireless.iwd = {
      enable = true;
      settings = {
        General = {
          AddressRandomization = "network";
        };
      };
    };
  };
}
