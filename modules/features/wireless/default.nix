{ self, ... }: {
  flake.nixosModules.wireless = { pkgs, ... }: {
    imports = [
      self.nixosModules.bt
      self.nixosModules.iwd
    ];
  };
}
