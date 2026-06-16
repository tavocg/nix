{ ... }: {
  flake.nixosModules.fonts = { pkgs, ... }:
  let
    iosevkaAile = pkgs.iosevka-bin.override { variant = "Aile"; };
    iosevkaEtoile = pkgs.iosevka-bin.override { variant = "Etoile"; };
  in {
    fonts.packages = with pkgs; [
      cm_unicode
      corefonts
      iosevka
      iosevkaAile
      iosevkaEtoile
      jetbrains-mono
      lmodern
      newcomputermodern
      nerd-fonts.iosevka
      nerd-fonts.iosevka-term
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only
      symbola
    ];
  };
}
