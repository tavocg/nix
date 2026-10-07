{ ... }: {
  flake.nixosModules.packagesGUITheme = {
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
        gtk3
        gsettings-desktop-schemas
        gnome-themes-extra
      ] ++ lib.optionals x11Enabled [
        pkgs.xsettingsd
      ];

      environment.sessionVariables.XDG_DATA_DIRS = [
        "${pkgs.glib.getSchemaPath pkgs.gtk3}"
        "${pkgs.glib.getSchemaPath pkgs.gsettings-desktop-schemas}"
      ];

      programs.dconf = {
        enable = true;
        profiles.user.databases = [
          {
            settings = {
              "org/gnome/desktop/interface" = {
                color-scheme = "prefer-dark";
                gtk-theme = "Adwaita-dark";
              };
            };
          }
        ];
      };
    };
  };
}
