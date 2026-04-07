{ ... }: {
  flake.nixosModules.autologin = { pkgs, ... }: {
    services.getty = {
      autologinUser = "tavo";
      autologinOnce = true;
    };

    environment.loginShellInit = ''
      if [[ "$(tty)" == /dev/tty1 ]]; then
        exec sway
      fi
    '';
  };
}
