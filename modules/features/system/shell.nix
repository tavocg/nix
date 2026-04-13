{ inputs, ... }: {
  flake.nixosModules.shell = { pkgs, ... }: {
    users.defaultUserShell = pkgs.bashInteractive;
    environment.shells = [ pkgs.bashInteractive ];

    programs.bash = let
      bashrcPath = "${inputs.dotfiles}/bashrc";
    in {
      enable = true;

      interactiveShellInit = ''
        source ${bashrcPath}
      '';

      loginShellInit = ''
        source ${bashrcPath}
      '';
    };
  };
}
