{ inputs, ... }: {
  flake.homeModules.sway = { ... }: {
    imports = [
      ./foot.nix
      ./programs.nix
    ];

    xdg.configFile."sway/config".source = "${inputs.dotfiles}/sway/config";
  };
}
