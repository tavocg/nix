{ inputs, ... }: {
  flake.homeModules.sway = { pkgs, ... }: {
    home.packages = [ pkgs.sway ];

    home.file.".config/sway/config".source = "${inputs.dotfiles}/sway/config";
  };
}
