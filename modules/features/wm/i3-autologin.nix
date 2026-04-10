{ ... }: {
  flake.nixosModules.i3Autologin = { config, lib, ... }: {
    programs.bash.loginShellInit = ''
      if [[ "$(tty)" == /dev/tty1 ]]; then
        exec ${lib.getExe config.services.xserver.windowManager.i3.package}
      fi
    '';

    services.getty = {
      autologinUser = "tavo";
      autologinOnce = false; # TODO: should be true? but it didnt seem to work when true?
    };
  };
}
