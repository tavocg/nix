{ ... }: {
  flake.nixosModules.wol = { pkgs, ... }: {
    environment.systemPackages = [
      pkgs.wakeonlan
    ];

    networking.firewall.allowedUDPPorts = [ 9 ];

    systemd.network.links."40-wake-on-lan" = {
      matchConfig.OriginalName = "en* eth*";
      linkConfig.WakeOnLan = "magic";
    };
  };
}
