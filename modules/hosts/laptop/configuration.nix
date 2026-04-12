{ self, inputs, ... }: {
  flake.nixosModules.laptopConfiguration = { config, pkgs, lib, ... }: {
    networking.hostName = "laptop";
    console.keyMap = "la-latin1";

    imports = [
      self.nixosModules.laptopHardware
      self.nixosModules.environment
      inputs.home-manager.nixosModules.home-manager
      self.nixosModules.nixos
      self.nixosModules.system
      self.nixosModules.wireless
    ];

    local.user = {
      enable = true;
      name = "tavo";
      description = "Gustavo Calvo";
    };

    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.extraSpecialArgs = {
      inherit inputs;
    };

    home-manager.users.${config.local.user.name} = {
      imports = [ self.homeModules.sway ];
      home.stateVersion = config.system.stateVersion;
    };

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    system.stateVersion = "25.11";
  };
}
