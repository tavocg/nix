{ inputs, pkgs, ... }: {
  home.packages = [ pkgs.foot ];

  xdg.configFile."foot/foot.ini".source = "${inputs.dotfiles}/foot/foot.ini";
}
