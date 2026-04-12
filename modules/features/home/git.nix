{ inputs, ... }: {
  flake.homeModules.git = { lib, ... }: {
    xdg.configFile."git".source = lib.mkForce "${inputs.dotfiles}/git";
  };
}
