{ inputs, ... }: {
  flake.homeModules.swayConfig = { lib, ... }: {
    xdg.configFile."sway/config".source = lib.mkForce "${inputs.dotfiles}/sway/config";
    xdg.configFile."foot/foot.ini".source = "${inputs.dotfiles}/foot/foot.ini";
  };
}
