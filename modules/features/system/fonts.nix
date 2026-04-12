{ ... }: {
  flake.nixosModules.fonts = { pkgs, ... }: {
    fonts.packages = with pkgs; [
      corefonts
      jetbrains-mono
      nerd-fonts.jetbrains-mono
    ];
  };
}
