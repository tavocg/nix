{ inputs, ... }: {
  flake.homeModules.git = { lib, ... }: {
    xdg.configFile."git" = lib.mkForce {
      source = "${inputs.dotfiles}/git";
      force = true;
    };
  };
}
