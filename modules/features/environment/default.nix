{ self, ... }: {
  flake.nixosModules.environment = { pkgs, ... }: {
    imports = [
      self.nixosModules.environmentPackages
    ];
  };
}
