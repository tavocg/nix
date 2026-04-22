{ self, ... }: {
  flake.nixosModules.environment = { ... }: {
    imports = [
      self.nixosModules.environmentTheme
      self.nixosModules.environmentPackages
      self.nixosModules.environmentDev
    ];
  };
}
