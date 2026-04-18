{ self, ... }: {
  flake.nixosModules.driveConfiguration = { pkgs, ... }: {
    networking.hostName = "drive";

    imports = [
      self.nixosModules.nixos
      self.nixosModules.binsh
      self.nixosModules.cr
      self.nixosModules.tailscale
      self.nixosModules.ssh
      self.nixosModules.user
    ];

    local.user = {
      enable = true;
      name = "drive";
      description = "Drive";
      extraGroups = [ "wheel" ];
    };

    local.ssh.enable = true;

    services.resolved.enable = true;
    services.resolved.settings.Resolve = {
      FallbackDNS = [
        "1.1.1.1"
        "8.8.8.8"
      ];
    };

    systemd.network.networks."50-tailscale0" = {
      matchConfig.Name = "tailscale0";
      DHCP = "no";
      networkConfig = {
        IPv6AcceptRA = false;
        LinkLocalAddressing = "no";
      };
    };

    security.sudo.wheelNeedsPassword = false;

    environment.systemPackages = with pkgs; [
      git
      tmux
      curl
    ];

    system.stateVersion = "25.11";
  };
}
