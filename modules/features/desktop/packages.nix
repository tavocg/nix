{ self, ... }: {
  flake.nixosModules.packages = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      firefox
      obs-studio
      xournalpp
      gimp
      kdePackages.kdenlive
    ];
  };
}
