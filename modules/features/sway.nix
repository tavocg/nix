{ inputs, ... }: {
  flake.nixosModules.sway = { pkgs, ... }: {
    local.wayland.enable = true;

    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      extraPackages = with pkgs; [
        wl-clipboard
        bemenu
        slurp
        grim
        wtype
        foot
        inputs.shtatus.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };
  };
}
