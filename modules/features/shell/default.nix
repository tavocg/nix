{ self, ... }: {
  flake.nixosModules.shell = { pkgs, ... }: {
    imports = [
    ];

    programs.bash = {
      enable = true;
      interactiveShellInit = ''
        if [ -r ~/.config/shell/bashrc ]; then
          . ~/.config/shell/bashrc
        fi
      '';
      loginShellInit = ''
        for f in ~/.config/shell/profile.d/*.sh; do
          if [ -r "$f" ]; then
            . "$f"
          fi
        done
      '';
    };

    users.defaultUserShell = pkgs.bashInteractive;

    environment.systemPackages = with pkgs; [
      git
      lazygit
      yazi
      eza
    ];
  };
}
