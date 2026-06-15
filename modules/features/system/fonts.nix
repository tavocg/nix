{ ... }: {
  flake.nixosModules.fonts = { pkgs, ... }: {
    fonts.packages = with pkgs; [
      cm_unicode
      corefonts
      iosevka
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
