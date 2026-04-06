{ ... }: {
  flake.nixosModules.tavo-autologin = { pkgs, ... }: {
    services.getty = {
      autologinUser = "tavo";
      autologinOnce = true;
    };

    environment.loginShellInit = ''
      [[ "$(tty)" == /dev/tty1 ]] && sway
    '';
  };
}
