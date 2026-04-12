{ self, ... }: {
  flake.homeModules.home = { lib, ... }: {
    xdg.enable = true;

    imports = [
      self.homeModules.bash
      self.homeModules.codex
      self.homeModules.extra
      self.homeModules.git
      self.homeModules.gnupg
      self.homeModules.pass
      self.homeModules.ssh
    ];
  };
}
