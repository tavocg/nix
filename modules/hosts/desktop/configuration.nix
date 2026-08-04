{ self, ... }: {
  flake.nixosModules.desktopConfiguration = { ... }: {
    networking.hostName = "desktop";

    imports = [
      self.nixosModules.desktopHardware

      self.nixosModules.nixos
      self.nixosModules.packages
      self.nixosModules.system
      self.nixosModules.systemDocker
      self.nixosModules.systemPrintingEpsonL3150
      self.nixosModules.systemWOL
      self.nixosModules.systemUSBIPHost
      self.nixosModules.systemUSBIPClient
      self.nixosModules.networkBT
      self.nixosModules.networkTailscale

      self.nixosModules.desktopHyprland
      self.nixosModules.desktopHyprlandAutologin
      self.nixosModules.gaming

      self.nixosModules.gpuNvidiaGTX1060
      self.nixosModules.gpuCUDA
      self.nixosModules.xmrig
    ];

    local.user = {
      enable = true;
      name = "tavo";
      description = "Gustavo Calvo";
    };

    local.ssh.enable = true;
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    system.stateVersion = "25.11";
  };
}
