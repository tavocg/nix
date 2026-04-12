{ self, inputs, ... }: {
  flake.nixosModules.laptopConfiguration = { pkgs, lib, ... }: {
    networking.hostName = "laptop";
    console.keyMap = "la-latin1";

    imports = [
      self.nixosModules.laptopHardware
      self.nixosModules.environment
      self.nixosModules.nixos
      self.nixosModules.system
      self.nixosModules.wireless
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
