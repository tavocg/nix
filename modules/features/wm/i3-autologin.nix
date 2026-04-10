{ ... }: {
  flake.nixosModules.i3Autologin = { lib, pkgs, ... }: {
    programs.bash.loginShellInit = lib.mkAfter ''
      if [[ -z "$DISPLAY" && "$(tty)" == /dev/tty1 ]]; then
        exec ${pkgs.xorg.xinit}/bin/startx
      fi
    '';

    services.getty = {
      autologinUser = "tavo";
      autologinOnce = false; # TODO: should be true? but it didnt seem to work when true?
    };
  };
}
