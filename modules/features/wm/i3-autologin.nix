{ self, ... }: {
  flake.nixosModules.i3Autologin = { lib, pkgs, ... }: {
    programs.bash.loginShellInit = ''
      if [[ "$(tty)" == /dev/tty1 && -z "${DISPLAY:-}" ]]; then
        exec ${lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.startx}
      fi
    '';

    services.getty = {
      autologinUser = "tavo";
      autologinOnce = false;
    };
  };
}
