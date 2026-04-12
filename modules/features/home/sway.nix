{ inputs, ... }: {
  flake.homeModules.sway = { pkgs, ... }: {
    wayland.windowManager.sway.enable = true;

    home.packages = [
      pkgs.foot
      pkgs.grim
      pkgs.slurp
      pkgs.wl-clipboard
      pkgs.bemenu
      inputs.anypinentry.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    xdg.configFile."sway/config".source = "${inputs.dotfiles}/sway/config";
    xdg.configFile."foot/foot.ini".source = "${inputs.dotfiles}/foot/foot.ini";
  };
}
