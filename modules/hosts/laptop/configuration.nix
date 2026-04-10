{ self, inputs, ... }: {
  flake.nixosModules.laptopConfiguration = { pkgs, lib, ... }: {
    imports = [
      self.nixosModules.laptopHardware
      self.nixosModules.desktop
      self.nixosModules.nixos
      self.nixosModules.shell
      self.nixosModules.system
      self.nixosModules.iwd
      self.nixosModules.swayAutologin
      self.nixosModules.sway
    ];

    networking.hostName = "laptop";

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    console.keyMap = "la-latin1";

    system.stateVersion = "25.11";
  };
}
