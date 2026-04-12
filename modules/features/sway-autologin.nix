{ ... }: {
  flake.nixosModules.swayAutologin = { config, lib, ... }: {
    config = lib.mkMerge [
      (lib.mkIf config.programs.sway.enable {
        programs.bash.loginShellInit = ''
          if [[ "$(tty)" == /dev/tty1 ]]; then
            exec ${lib.getExe config.programs.sway.package}
          fi
        '';
      })
      (lib.mkIf config.local.user.enable {
        services.getty = {
          autologinUser = config.local.user.name;
          autologinOnce = false; # TODO: should be true? but it didnt seem to work when true?
        };
      })
    ];
  };
}
