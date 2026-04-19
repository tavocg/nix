{ inputs, ... }: {
  flake.nixosModules.hyprland = { pkgs, ... }: {
    local.wayland.enable = true;

    environment.systemPackages = [
      pkgs.foot
    ];

    programs.hyprland = {
      enable = true;
      withUWSM = true;
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
            exec ${
              if config.programs.hyprland.withUWSM then
                "${lib.getExe config.programs.uwsm.package} start -F -- /run/current-system/sw/bin/Hyprland"
              else
                "/run/current-system/sw/bin/Hyprland"
            }
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
