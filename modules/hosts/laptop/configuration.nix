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

    environment.systemPackages = [
      pkgs.brightnessctl
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    system.stateVersion = "25.11";
  };
}
