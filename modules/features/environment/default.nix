{ self, ... }: {
  flake.nixosModules.environment = { ... }: {
    imports = [
      self.nixosModules.environmentDark
      self.nixosModules.environmentPackages
    ];
  };
}
