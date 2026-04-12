{ self, ... }: {
  flake.homeModules.home = { lib, ... }: {
    imports = [
      self.homeModules.bash
      self.homeModules.codex
      self.homeModules.git
      self.homeModules.gnupg
      self.homeModules.pass
      self.homeModules.ssh
    ];
  };
}
