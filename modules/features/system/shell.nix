{ inputs, ... }: {
  flake.nixosModules.shell = {
    programs.bash = let
      bashrcPath = "${inputs.dotfiles}/bashrc";
    in {
      interactiveShellInit = ''
        source ${bashrcPath}
      '';

      loginShellInit = ''
        source ${bashrcPath}
      '';
    };
  };
}
