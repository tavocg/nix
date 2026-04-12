{ self, inputs, ... }: {
  flake.nixosModules.home = { config, ... }: {
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.extraSpecialArgs = {
      inherit inputs;
    };

    home-manager.users.${config.local.user.name} = {
      imports = [
        self.homeModules.foot
        self.homeModules.sway
      ];
      home.stateVersion = config.system.stateVersion;
    };
  };
}
