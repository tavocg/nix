{ self, ... }: {
  flake.nixosModules.nixos = { pkgs, ... }: {
    imports = [
      self.nixosModules.flakes
      self.nixosModules.unfree
    ];
  };
}
