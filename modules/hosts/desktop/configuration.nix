{ self, inputs, ... }: {
  flake.nixosModules.desktopConfiguration = { config, pkgs, lib, ... }: {
    networking.hostName = "desktop";

    imports = [
      inputs.home-manager.nixosModules.home-manager

      self.nixosModules.desktopHardware

      self.nixosModules.nixos
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

    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.extraSpecialArgs = {
      inherit inputs;
    };

    home-manager.users.${config.local.user.name} = {
      imports = [
        self.homeModules.swayConfig
        self.homeModules.home
      ];
      home.stateVersion = config.system.stateVersion;
    };

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    system.stateVersion = "25.11";
  };
}
