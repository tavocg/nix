{ self, ... }: {
  flake.nixosModules.desktopConfiguration = { ... }: {
    networking.hostName = "desktop";

    imports = [
      self.nixosModules.desktopHardware

      self.nixosModules.nixos
      self.nixosModules.environment
      self.nixosModules.system
      self.nixosModules.bt

      self.nixosModules.tailscale

      self.nixosModules.i3
      self.nixosModules.i3Autologin
      self.nixosModules.nvidiaProprietary
    ];

    programs.steam.enable = true;

    local.user = {
      enable = true;
      name = "tavo";
      description = "Gustavo Calvo";
    };

    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
      };
    };

    users.users."tavo".openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFKPVj4UOvvNv5JxeJ0mfe+5gWNMnKIyW9wLykSPRlPM tavo@desktop"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHkCMsi9s7M0RROph5s1jmBEBo7JYIL53hPWxN3NK1nj tavo@laptop"
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    system.stateVersion = "25.11";
  };
}
