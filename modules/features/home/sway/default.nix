{ inputs, ... }: {
  flake.homeModules.sway = { ... }: {
    imports = [
      ./foot.nix
      ./programs.nix
    ];

    home.file.".config/sway/config".source = "${inputs.dotfiles}/sway/config";
  };
}
