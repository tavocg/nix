{ self, inputs, ... }: {
  flake.nixosModules.desktopConfiguration = { pkgs, lib, ... }: {
    networking.hostName = "desktop";

    imports = [
      self.nixosModules.desktopHardware
      self.nixosModules.environment
      self.nixosModules.home
      self.nixosModules.nixos
      self.nixosModules.system
      self.nixosModules.bt
    ];

    local.user = {
      enable = true;
      name = "tavo";
      description = "Gustavo Calvo";
    };

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    system.stateVersion = "25.11";
  };
}
