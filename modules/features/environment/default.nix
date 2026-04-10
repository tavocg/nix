{ self, ... }: {
  flake.nixosModules.environment = { pkgs, ... }: {
    imports = [
      self.nixosModules.environmentVariables
      self.nixosModules.environmentPackages
    ];
  };
}
