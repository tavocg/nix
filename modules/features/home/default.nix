{ self, ... }: {
  flake.homeModules.home = { lib, ... }: {
    imports = [
      self.homeModules.gnupg
    ];
  };
}
