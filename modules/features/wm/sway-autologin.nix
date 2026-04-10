{ ... }: {
  flake.nixosModules.swayAutologin = { config, lib, ... }: {
    programs.bash.loginShellInit = ''
      if [[ "$(tty)" == /dev/tty1 ]]; then
        exec ${lib.getExe config.programs.sway.package}
      fi
    '';

    services.getty = {
      autologinUser = "tavo";
      autologinOnce = true;
    };
  };
}
