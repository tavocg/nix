{ ... }: {
  flake.nixosModules.i3Autologin = { config, lib, ... }: {
    config = lib.mkMerge [
      (lib.mkIf config.services.xserver.windowManager.i3.enable {
        programs.bash.loginShellInit = ''
          if [[ -z "$DISPLAY" ]] && [[ "$(tty)" == /dev/tty1 ]]; then
            exec startx "$HOME/.config/X11/xinit/xinitrc"
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
