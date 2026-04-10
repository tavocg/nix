{ self, ... }: {
  flake.nixosModules.extra = { pkgs, ... }: {
    imports = [
      self.nixosModules.packages
    ];
  };
}
