{ self, ... }: {
  flake.nixosModules.packages = { ... }: {
    imports = [
      self.nixosModules.packagesBase
      self.nixosModules.packagesDev
      self.nixosModules.packagesGUI
    ];
  };
}
