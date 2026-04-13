{ ... }: {
  flake.nixosModules.shell = { pkgs, ... }: {
    users.defaultUserShell = pkgs.bashInteractive;
    environment.shells = [ pkgs.bashInteractive ];
    environment.shellAliases = {
      l = null;
      ll = null;
      ls = null;
    };

    programs.bash = {
      enable = true;

      loginShellInit = ''
        if [ -r ~/.config/bashrc ]; then
          . ~/.config/bashrc
        fi
      '';

      # NixOS writes its default prompt via promptInit, so source ~/.config/bashrc
      # there to keep PS1/PROMPT_COMMAND from being overwritten when present.
      promptInit = ''
        if [ -r ~/.config/bashrc ]; then
          . ~/.config/bashrc
        fi
      '';
    };
  };
}
