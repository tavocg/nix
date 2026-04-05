{ self, inputs, ... }: {
  flake.nixosModules.sway = { pkgs, ... }: {
    programs.sway = {
      enable = true;
      xwayland.enable = true;
      wrapperFeatures.gtk = true;
      extraPackages = with pkgs; [
        bemenu
        foot
        waybar
        wmenu
      ];
      extraConfig = ''
        set $mod Mod4

        bindsym $mod+Return exec ${pkgs.foot}/bin/foot
        bindsym $mod+r exec ${pkgs.bemenu}/bin/bemenu-run
      '';
    };

    security.polkit.enable = true;

    services.greetd = {
      enable = true;
      settings.default_session.command =
        "${pkgs.tuigreet}/bin/tuigreet --time --cmd sway";
    };

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
    };
  };
}
