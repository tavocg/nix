{ self, inputs, ... }: {
  flake.nixosModules.laptopConfiguration = { pkgs, lib, ... }: {
    imports = [
      self.nixosModules.laptopHardware
      self.nixosModules.cr
      self.nixosModules.cups
      self.nixosModules.flakes
      self.nixosModules.fonts
      self.nixosModules.pipewire
      self.nixosModules.shell
      self.nixosModules.sway
      self.nixosModules.tavo
      self.nixosModules.unfree
      self.nixosModules.wifi
    ];

    networking.hostName = "laptop";

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    console.keyMap = "la-latin1";

    system.stateVersion = "25.11";
  };
}
