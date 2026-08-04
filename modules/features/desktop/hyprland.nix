{ ... }: {
  flake.nixosModules.desktopHyprland = { pkgs, ... }: {
    local.wayland.enable = true;

    environment.systemPackages = [
      pkgs.bemenu
      pkgs.foot
      pkgs.waybar
      pkgs.wl-clipboard
      pkgs.libnotify
      pkgs.wtype
      pkgs.grim
      pkgs.slurp
      pkgs.hyprpicker
      pkgs.hyprpaper
    ];

    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };

    services.dunst.enable = true;

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      LIBVA_DRIVER_NAME = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };
  };

  flake.nixosModules.desktopHyprlandAutologin = { config, lib, ... }: {
    config = lib.mkMerge [
      (lib.mkIf config.programs.hyprland.enable {
        programs.bash.loginShellInit = ''
          if [[ "$(tty)" == /dev/tty1 ]] && uwsm check may-start; then
            exec uwsm start hyprland.desktop
          fi
        '';
      })
      (lib.mkIf config.local.user.enable {
        services.getty = {
          autologinUser = config.local.user.name;
          autologinOnce = false;
        };
      })
    ];
  };
}
