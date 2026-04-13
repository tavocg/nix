{ self, ... }: {
  flake.nixosModules.wireless = { ... }: {
    imports = [
      self.nixosModules.bt
      self.nixosModules.iwd
    ];
  };
}
