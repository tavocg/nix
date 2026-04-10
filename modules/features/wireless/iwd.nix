{ ... }: {
  flake.nixosModules.iwd = { pkgs, ... }: {
    networking.dhcpcd.enable = false;
    networking.networkmanager.enable = false;
    networking.resolvconf.enable = true;

    networking.wireless.iwd = {
      enable = true;
      settings = {
        General = {
          AddressRandomization = "network";
          EnableNetworkConfiguration = true;
        };
        Network = {
          NameResolvingService = "resolvconf";
        };
      };
    };

    environment.systemPackages = with pkgs; [
      impala
    ];
  };
}
