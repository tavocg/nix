{ ... }: {
  flake.nixosModules.environmentGUI = {
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
    config = lib.mkIf windowingEnabled {
      environment.systemPackages = with pkgs; [
        signal-desktop
        imv
        vlc
        mpv
        obsidian
        firefox
        chromium
        thunderbird
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
        rstudio
        discord
        godot
      ];
    };
  };
}
