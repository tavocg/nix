{ inputs, ... }: {
  flake.homeModules.git = { lib, ... }: {
    xdg.configFile."git/config".source = lib.mkForce "${inputs.dotfiles}/git/config";
  };
}
