{ self, ... }: {
  flake.homeModules.home = { lib, ... }: {
    xdg.enable = true;

    imports = [
      self.homeModules.extra
      self.homeModules.gnupg
      self.homeModules.pass
    ];

    xdg.configFile."git".source = "${inputs.dotfiles}/git";
    xdg.configFile."ssh".source = lib.mkForce "${inputs.dotfiles}/ssh";
  };
}
