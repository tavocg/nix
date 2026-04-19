{ inputs, ... }: {
  flake.nixosModules.i3 = { pkgs, ... }: {
    local.x11.enable = true;

    environment.systemPackages = [
      pkgs.xclip
      pkgs.bemenu
      pkgs.scrot
      pkgs.xcolor
      pkgs.xdotool
      pkgs.gnome-themes-extra
      pkgs.xsettingsd
      inputs.st.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.shtatus.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    environment.etc."xdg/xsettingsd/xsettingsd.conf".text = ''
      Net/ThemeName "Adwaita-dark"
      Gtk/ApplicationPreferDarkTheme 1
    '';

    environment.etc."X11/xinit/xinitrc.d/03-xsettingsd.sh".text = ''
      ${pkgs.xsettingsd}/bin/xsettingsd -c /etc/xdg/xsettingsd/xsettingsd.conf &
    '';

    services.xserver = {
      enable = true;

      displayManager.startx.enable = true;

      windowManager.i3.enable = true;
    };
  };
}
