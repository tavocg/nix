{ inputs, self, ... }: {
  flake.nixosModules.i3Autologin = { lib, pkgs, ... }: {
    programs.bash.loginShellInit = ''
      if [[ "$(tty)" == /dev/tty1 && -z "''${DISPLAY:-}" ]]; then
        . ${inputs.dotfiles}/profile.d/00-xdg.sh

        export XDG_CURRENT_DESKTOP=i3
        export XDG_SESSION_DESKTOP=i3
        export DESKTOP_SESSION=i3
        export XDG_SESSION_TYPE=x11
        export GDK_BACKEND=x11

        exec ${lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.startx}
      fi
    '';

    services.getty = {
      autologinUser = "tavo";
      autologinOnce = false;
    };
  };
}
