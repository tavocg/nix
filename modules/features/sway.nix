{ inputs, ... }: {
  flake.nixosModules.sway = { pkgs, ... }: {
    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true;

      extraPackages = with pkgs; [
        foot
        wl-clipboard
        bemenu
        slurp
        grim
        inputs.shtatus.packages.${pkgs.system}.default
        inputs.anypinentry.packages.${pkgs.system}.default
      ];
    };
  };
}
