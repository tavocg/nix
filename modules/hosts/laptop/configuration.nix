{ self, inputs, ... }: {
  flake.nixosModules.laptopConfiguration = { config, pkgs, lib, ... }: {
    networking.hostName = "laptop";
    console.keyMap = "la-latin1";

    imports = [
      inputs.home-manager.nixosModules.home-manager

      self.nixosModules.laptopHardware

      self.nixosModules.nixos
      self.nixosModules.system
      self.nixosModules.wireless

      self.nixosModules.sway
      self.nixosModules.swayAutologin
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
      imports = [
        self.homeModules.home
        self.homeModules.swayConfig
      ];
      home.stateVersion = config.system.stateVersion;
    };

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    system.stateVersion = "25.11";
  };
}
