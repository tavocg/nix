{ inputs, ... }: {
  flake.homeModules.ssh = { lib, ... }: {
    xdg.configFile."ssh".source = lib.mkForce "${inputs.dotfiles}/ssh";
  };
}
