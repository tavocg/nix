{ inputs, ... }: {
  flake.homeModules.bash = { ... }: {
    programs.bash = {
      enable = true;
      bashrcExtra = builtins.readFile "${inputs.dotfiles}/bashrc";
    };
  };
}
