{ lib, ... }:
let
  mkStartxPackage =
    pkgs:
    pkgs.xinit.overrideAttrs (old: {
      pname = "startx";
      postFixup = lib.concatStringsSep "\n" [
        old.postFixup
        ''
          substituteInPlace $out/bin/startx \
            --replace-fail 'xserverauthfile="$HOME/.serverauth.$$"' 'xserverauthfile="$XDG_RUNTIME_DIR/serverauth.$$"'
        ''
      ];
    });
in
{
  perSystem = { pkgs, ... }: {
    packages = lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux {
      startx = mkStartxPackage pkgs;
    };
  };

  flake.nixosModules.startx =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      cfg = config.services.xserver.displayManager.startx;

      # WM session script
      # Note: this assumes a single WM has been enabled
      sessionScript = lib.concatMapStringsSep "\n" (i: i.start) config.services.xserver.windowManager.session;

      startxPackage = mkStartxPackage pkgs;
    in
    {
      disabledModules = [ "services/x11/display-managers/startx.nix" ];

      options = {
        services.xserver.displayManager.startx = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = ''
              Whether to enable the dummy "startx" pseudo-display manager, which
              allows users to start X manually via the `startx` command from a
              virtual terminal.

              ::: {.note}
              The X server will run under the current user, not as root.
              :::
            '';
          };

          generateScript = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = ''
              Whether to generate the system-wide xinitrc script (/etc/X11/xinit/xinitrc).
              This script will take care of setting up the session for systemd user
              services, running the window manager and cleaning up on exit.

              ::: {.note}
              This script will only be used by `startx` when both `.xinitrc` does not
              exists and the `XINITRC` environment variable is unset.
              :::
            '';
          };

          extraCommands = lib.mkOption {
            type = lib.types.lines;
            default = "";
            description = ''
              Shell commands to be added to the system-wide xinitrc script.
            '';
          };
        };
      };

      config = lib.mkIf cfg.enable {
        services.xserver.exportConfiguration = true;

        # Let Xorg use its default log location ($XDG_DATA_HOME/xorg/).
        services.xserver.logFile = lib.mkDefault null;

        environment.etc."X11/xinit/xserverrc".source = pkgs.writeShellScript "xserverrc" ''
          exec ${pkgs.xorg-server}/bin/X \
            ${toString config.services.xserver.displayManager.xserverArgs} "$@"
        '';

        environment.etc."X11/xinit/xinitrc" = lib.mkIf cfg.generateScript {
          source = pkgs.writeShellScript "xinitrc" ''
            ${cfg.extraCommands}

            systemctl --user import-environment DISPLAY XDG_SESSION_ID
            systemctl --user start nixos-fake-graphical-session.target

            ${sessionScript}
            wait $waitPID

            systemctl --user stop nixos-fake-graphical-session.target
            kill 0
          '';
        };

        environment.systemPackages = [ startxPackage ];
      };
    };
}
