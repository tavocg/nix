{ inputs, self, ... }: {
  flake.nixosModules.desktopPackages = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      firefox
      obs-studio
      mpv
      vlc
      imv
      zathura
      xournalpp
      gimp
      darktable
      libreoffice-fresh
      kdePackages.kdenlive

      inputs.anypinentry.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
