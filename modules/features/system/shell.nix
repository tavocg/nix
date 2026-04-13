{ inputs, ... }: {
  flake.nixosModules.shell = { pkgs, ... }: {
    users.defaultUserShell = pkgs.bashInteractive;
    environment.shells = [ pkgs.bashInteractive ];
    environment.shellAliases = {
      l = null;
      ll = null;
      ls = null;
    };

    programs.bash = let
      bashrcPath = "${inputs.dotfiles}/bashrc";
    in {
      enable = true;

      loginShellInit = ''
        source ${bashrcPath}
      '';

      # NixOS writes its default prompt via promptInit, so load the dotfiles
      # bashrc there to keep PS1/PROMPT_COMMAND from being overwritten.
      promptInit = ''
        source ${bashrcPath}
      '';
    };
  };
}
