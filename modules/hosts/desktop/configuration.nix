{ self, inputs, ... }: {
  flake.nixosModules.desktopConfiguration = { pkgs, lib, ... }: {
    imports = [
      self.nixosModules.desktopHardware
      self.nixosModules.environment
      self.nixosModules.extra
      self.nixosModules.nixos
      self.nixosModules.shell
      self.nixosModules.system
      # self.nixosModules.bt
      self.nixosModules.i3Autologin
      self.nixosModules.i3
    ];

    networking.hostName = "desktop";

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    system.stateVersion = "25.11";
  };
}
