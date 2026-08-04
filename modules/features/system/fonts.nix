{ ... }: {
  flake.nixosModules.systemFonts = { pkgs, ... }:
  let
    iosevkaAile = pkgs.iosevka-bin.override { variant = "Aile"; };
    iosevkaEtoile = pkgs.iosevka-bin.override { variant = "Etoile"; };
  in {
    fonts.packages = with pkgs; [
      jetbrains-mono
      nerd-fonts.jetbrains-mono
      symbola
      nerd-fonts.symbols-only
      # iosevka
      # iosevkaAile
      # iosevkaEtoile
      # nerd-fonts.iosevka
      # nerd-fonts.iosevka-term
      corefonts
      cm_unicode
      lmodern
      newcomputermodern
    ];
  };
}
