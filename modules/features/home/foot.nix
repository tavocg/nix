{ inputs, ... }: {
  flake.homeModules.foot = { pkgs, ... }: {
    home.packages = [ pkgs.foot ];

    home.file.".config/foot/foot.ini".source = "${inputs.dotfiles}/foot/foot.ini";
  };
}
