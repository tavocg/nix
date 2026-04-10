{ self, ... }: {
  flake.nixosModules.desktop = { pkgs, ... }: {
    imports = [
      self.nixosModules.desktopPackages
    ];
  };
}
