{ ... }: {
  flake.nixosModules.networkManagerIWD = { config, lib, ... }: {
    networking.dhcpcd.enable = false;
    networking.networkmanager.enable = true;
    networking.networkmanager.wifi.backend = "iwd";
    users.users.${config.local.user.name}.extraGroups = lib.mkAfter [ "networkmanager" ];
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
