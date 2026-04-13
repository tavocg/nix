{ self, ... }: {
  flake.nixosModules.environment = { ... }: {
    imports = [
      self.nixosModules.environmentPackages
    ];
  };
}
