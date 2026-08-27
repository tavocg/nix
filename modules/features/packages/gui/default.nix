{ self, ... }: {
  flake.nixosModules.packagesGUI = {
    config,
    lib,
    pkgs,
    ...
  }:

  let
    x11Enabled = config.local.x11.enable;
    waylandEnabled = config.local.wayland.enable;
    windowingEnabled = x11Enabled || waylandEnabled;
  in {
    imports = [
      self.nixosModules.packagesGUIOBS
      self.nixosModules.packagesGUITheme
      self.nixosModules.packagesGUINautilus
    ];

    config = lib.mkIf windowingEnabled {
      environment.systemPackages = with pkgs; [
        # web
        firefox
        discord

        # viewers
        imv
        mpv
        zathura

        # office
        libreoffice-stable
        xournalpp

        # creative
        gimp
        audacity
        kdePackages.kdenlive
        darktable
        config.local.packages.obs

        # tools
        gnome-disk-utility
        config.local.packages.nautilus

        # misc
        qbittorrent
      ];
    };
  };
}
