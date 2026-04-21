{ ... }: {
  flake.nixosModules.environmentTheme = {
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
        gnome-themes-extra
      ] ++ lib.optionals x11Enabled [
        pkgs.xsettingsd
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
