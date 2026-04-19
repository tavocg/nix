{ config, inputs, ... }: {
  flake.nixosModules.i3 = { pkgs, ... }: {
    imports = [ config.flake.nixosModules.startx ];

    local.x11.enable = true;

    environment.systemPackages = [
      pkgs.xclip
      pkgs.bemenu
      pkgs.scrot
      pkgs.xcolor
      pkgs.xdotool
      inputs.st.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.shtatus.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    services.xserver = {
      enable = true;

      displayManager.startx.enable = true;

      windowManager.i3.enable = true;
    };
  };

  flake.nixosModules.i3Autologin = { config, lib, ... }: {
    config = lib.mkMerge [
      (lib.mkIf config.services.xserver.windowManager.i3.enable {
        programs.bash.loginShellInit = ''
          if [[ -z "$DISPLAY" ]] && [[ "$(tty)" == /dev/tty1 ]]; then
            if [[ -f "''${XDG_CONFIG_HOME:-$HOME/.config}/X11/xinit/xinitrc" ]]; then
              exec startx "''${XDG_CONFIG_HOME:-$HOME/.config}/X11/xinit/xinitrc"
            else
              exec startx
            fi
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
