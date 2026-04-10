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
        inputs.shtatus.packages.${pkgs.stdenv.hostPlatform.system}.default
        inputs.anypinentry.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };
  };
}
