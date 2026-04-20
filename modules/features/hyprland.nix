{ ... }: {
  flake.nixosModules.hyprland = { pkgs, ... }: {
    local.wayland.enable = true;

    environment.systemPackages = [
      pkgs.bemenu
      pkgs.foot
      pkgs.waybar
      pkgs.wl-clipboard
      pkgs.wtype
      pkgs.grim
      pkgs.slurp
      pkgs.hyprpicker
    ];

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      LIBVA_DRIVER_NAME = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };
  };

  flake.nixosModules.hyprlandAutologin = { config, lib, ... }: {
    config = lib.mkMerge [
      (lib.mkIf config.programs.hyprland.enable {
        programs.bash.loginShellInit = ''
          if [[ -z "$WAYLAND_DISPLAY" ]] && [[ -z "$DISPLAY" ]] && [[ "$(tty)" == /dev/tty1 ]]; then
            exec /run/current-system/sw/bin/start-hyprland
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
