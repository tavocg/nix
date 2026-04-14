{ self, ... }: {
  flake.nixosModules.laptopConfiguration = { pkgs, ... }: {
    networking.hostName = "laptop";
    console.keyMap = "la-latin1";

    imports = [
      self.nixosModules.laptopHardware

      self.nixosModules.nixos
      self.nixosModules.environment
      self.nixosModules.system
      self.nixosModules.wireless

      self.nixosModules.tailscale

      self.nixosModules.sway
      self.nixosModules.swayAutologin
    ];

    local.user = {
      enable = true;
      name = "tavo";
      description = "Gustavo Calvo";
    };

    local.ssh = {
      enable = true;
      localKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFKPVj4UOvvNv5JxeJ0mfe+5gWNMnKIyW9wLykSPRlPM tavo@desktop"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHkCMsi9s7M0RROph5s1jmBEBo7JYIL53hPWxN3NK1nj tavo@laptop"
      ];
    };

    environment.systemPackages = [
      pkgs.brightnessctl
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    system.stateVersion = "25.11";
  };
}
