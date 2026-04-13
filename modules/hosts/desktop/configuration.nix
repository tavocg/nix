{ self, inputs, ... }: {
  flake.nixosModules.desktopConfiguration = { config, pkgs, lib, ... }: {
    networking.hostName = "desktop";

    imports = [
      self.nixosModules.desktopHardware

      self.nixosModules.nixos
      self.nixosModules.environment
      self.nixosModules.system
      self.nixosModules.bt

      self.nixosModules.sway
      self.nixosModules.swayAutologin
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
