{ inputs, ... }: {
  flake.nixosModules.sway = { pkgs, ... }: {
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

  flake.homeModules.swayConfig = { lib, ... }: {
    xdg.configFile."sway/config".source = lib.mkForce "${inputs.dotfiles}/sway/config";
    xdg.configFile."foot/foot.ini".source = lib.mkForce "${inputs.dotfiles}/foot/foot.ini";
  };
}
