{ self, ... }: {
  flake.nixosModules.shell = { pkgs, ... }: {
    imports = [
    ];

    # programs.bash = {
    #   enable = true;
    #   shellInit = ''
    #     if [ -r ~/.config/shell/bashrc ]; then
    #       . ~/.config/shell/bashrc
    #     fi
    #   '';
    # };

    programs.bash = {
      enable = true;
      bashrcExtra = ''
        if [ -r ~/.config/shell/bashrc ]; then
          . ~/.config/shell/bashrc
        fi
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
