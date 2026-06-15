{ ... }: {
  flake.nixosModules.fonts = { pkgs, ... }:
  let
    iosevkaEtoile = pkgs.iosevka.override { set = "Etoile"; };
  in {
    fonts.packages = with pkgs; [
      cm_unicode
      corefonts
      iosevka
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
