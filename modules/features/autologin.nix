{ ... }: {
  flake.nixosModules.autologin = {
    programs.bash.loginShellInit = ''
      if [[ "$(tty)" == /dev/tty1 ]]; then
        exec sway
      fi
    '';

    services.getty = {
      autologinUser = "tavo";
      autologinOnce = true;
    };
  };
}
