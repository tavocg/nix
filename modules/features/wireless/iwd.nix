{ ... }: {
  flake.nixosModules.iwd = { pkgs, ... }: {
    networking.dhcpcd.enable = false;
    networking.networkmanager.enable = false;
    services.resolved.enable = true;

    networking.wireless.iwd = {
      enable = true;
      settings = {
        General = {
          AddressRandomization = "network";
          EnableNetworkConfiguration = true;
        };
      };
    };
  };
}
