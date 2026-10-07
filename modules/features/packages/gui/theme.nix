{ ... }: {
  flake.nixosModules.packagesGUITheme = { config, lib, pkgs, ... }:
    let
      x11Enabled = config.local.x11.enable;
      waylandEnabled = config.local.wayland.enable;
      windowingEnabled = x11Enabled || waylandEnabled;
    in
  {
    config = lib.mkIf windowingEnabled {
      environment.systemPackages = with pkgs; [
        gtk3
        gsettings-desktop-schemas
        gnome-themes-extra
      ] ++ lib.optionals x11Enabled [
        pkgs.xsettingsd
      ];

      environment.extraInit = ''
        export XDG_DATA_DIRS="${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}:${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}''${XDG_DATA_DIRS:+:$XDG_DATA_DIRS}"
      '';

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
