{ self, ... }: {
  flake.nixosModules.packages = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      firefox
      obs-studio
      mpv
      vlc
      imv
      zathura
      xournalpp
      gimp
      kdePackages.kdenlive
    ];
  };
}
