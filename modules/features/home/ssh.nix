{ inputs, ... }: {
  flake.homeModules.ssh = { lib, ... }: {
    xdg.configFile."ssh".source = lib.mkForce "${inputs.dotfiles}/ssh";

    home.sessionVariablesExtra = ''
      export SSH_CONFIG="-F ''${XDG_CONFIG_HOME:-$HOME/.config}/ssh/config"
      export GIT_SSH_COMMAND="ssh ''${SSH_CONFIG}"
    '';

    programs.bash.shellAliases = {
      ssh = ''ssh ''${SSH_CONFIG}'';
      scp = ''scp ''${SSH_CONFIG}'';
      rsync = ''rsync --rsh "ssh ''${SSH_CONFIG}"'';
    };
  };
}
