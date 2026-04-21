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
      environment = {
        systemPackages = with pkgs; [
          gnome-themes-extra
          adwaita-qt
          libsForQt5.qt5ct
          kdePackages.qt6ct
        ];

        sessionVariables = {
          QT_QPA_PLATFORMTHEME = "qt5ct";
        };
      };

      # I think the following will allow setting the theme without touching
      # ~/.config/(gtk...|qt...)/

      # environment.systemPackages = lib.optionals x11Enabled [
      #   pkgs.xsettingsd
      # ];

      # programs.dconf = {
      #   enable = true;
      #   profiles.user.databases = [
      #     {
      #       settings = {
      #         "org/gnome/desktop/interface" = {
      #           color-scheme = "prefer-dark";
      #           gtk-theme = "Adwaita-dark";
      #         };
      #       };
      #     };
      #   ];
      # };

      # environment.etc = {
      #   "xdg/qt5ct/qt5ct.conf".text = ''
      #     [Appearance]
      #     style=adwaita-dark
      #   '';
      #   "xdg/qt6ct/qt6ct.conf".text = ''
      #     [Appearance]
      #     style=adwaita-dark
      #   '';
      # };
    };
  };
}
