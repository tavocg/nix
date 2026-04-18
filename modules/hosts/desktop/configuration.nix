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
      self.nixosModules.nvidiaCuda
    ];

    programs.steam.enable = true;

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
