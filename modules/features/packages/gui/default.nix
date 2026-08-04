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
      self.nixosModules.packagesGUIEmacs
      self.nixosModules.packagesGUIOBS
      self.nixosModules.packagesGUITheme
      self.nixosModules.packagesGUINautilus
    ];

    config = lib.mkIf windowingEnabled {
      environment.systemPackages = with pkgs; [
        imv
        mpv
        firefox
        libreoffice-fresh
        gnome-disk-utility
        gimp
        audacity
        kdePackages.kdenlive
        darktable
        config.local.environment.packages.obs
        xournalpp
        zathura
        qbittorrent
        discord
      ];
    };
  };
}
