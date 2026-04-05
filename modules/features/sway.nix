{ self, inputs, ... }:
let
  swaySupportPackages = pkgs: with pkgs; [
    bemenu
    foot
    waybar
    wmenu
  ];
in {
  flake.nixosModules.sway = { pkgs, ... }: {
    programs.sway = {
      enable = true;
      xwayland.enable = true;
      wrapperFeatures.gtk = true;
      extraPackages = swaySupportPackages pkgs;
    };

    environment.etc."sway/config.d/99-local.conf".text = ''
      set $mod Mod4

      bindsym $mod+Return exec ${pkgs.foot}/bin/foot
      bindsym $mod+r exec ${pkgs.bemenu}/bin/bemenu-run
    '';

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

  perSystem = { pkgs, ... }: {
    apps.sway = {
      type = "app";
      program = "${pkgs.writeShellApplication {
        name = "sway";
        runtimeInputs = [ pkgs.sway ] ++ swaySupportPackages pkgs;
        text = ''
          exec sway "$@"
        '';
      }}/bin/sway";
    };

    packages.sway = pkgs.writeShellApplication {
      name = "sway";
      runtimeInputs = [ pkgs.sway ] ++ swaySupportPackages pkgs;
      text = ''
        exec sway "$@"
      '';
    };
  };
}
