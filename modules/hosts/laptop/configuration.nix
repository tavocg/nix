{ self, ... }: {
  flake.nixosModules.laptopConfiguration = { pkgs, ... }: {
    networking.hostName = "laptop";
    console.keyMap = "la-latin1";

    imports = [
      self.nixosModules.laptopHardware

      self.nixosModules.nixos
      self.nixosModules.gamingSunshine
      self.nixosModules.packages
      self.nixosModules.system
      self.nixosModules.systemDocker
      self.nixosModules.systemPrintingEpsonL3150
      self.nixosModules.systemUSBIPHost
      self.nixosModules.systemUSBIPClient
      self.nixosModules.networkBT
      self.nixosModules.networkIWD
      self.nixosModules.networkTailscale

      self.nixosModules.desktopHyprland
      self.nixosModules.desktopHyprlandAutologin
    ];

    local.user = {
      enable = true;
      name = "tavo";
      description = "Gustavo Calvo";
    };

    local.ssh.enable = true;

    environment.systemPackages = [
      pkgs.brightnessctl
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    system.stateVersion = "25.11";
  };
}
