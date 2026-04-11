{ inputs, self, ... }: {
  imports = [
    inputs.wrapper-modules.flakeModules.wrappers
  ];

  flake.wrappers.i3 = { config, pkgs, wlib, ... }: let
    i3ConfigPath = config.constructFiles.config.path;
  in {
    imports = [ wlib.modules.default ];

    config = {
      package = pkgs.i3;

      flags."-c" = i3ConfigPath;

      constructFiles.config = {
        relPath = "config";
        content = builtins.readFile "${inputs.dotfiles}/i3/config";
      };
    };
  };

  perSystem = { config, ... }: {
    wrappers = {
      control_type = "build";
      packages.i3 = true;
    };

    apps.i3 = {
      type = "app";
      program = "${config.packages.i3}/bin/i3";
    };
  };

  flake.nixosModules.i3 = { lib, pkgs, ... }:
    let
      x11Dir = "${inputs.dotfiles}/X11";

      mkEtcEntries = prefix: dir:
        lib.mapAttrs' (
          name: type:
            lib.nameValuePair "${prefix}/${name}" {
              source = "${dir}/${name}";
            }
        ) (
          lib.filterAttrs (_: type: type == "regular" || type == "symlink") (builtins.readDir dir)
        );
    in {
      services.xserver = {
        enable = true;

        displayManager.startx = {
          enable = true;
          generateScript = true;
          extraCommands = ''
            export DISPLAY="''${DISPLAY:-:0}"
            export XAUTHORITY="''${XAUTHORITY:-$XDG_RUNTIME_DIR/Xauthority}"
            export DESKTOP_SESSION=i3
            export XDG_CURRENT_DESKTOP=i3
            export XDG_SESSION_DESKTOP=i3
            export XDG_SESSION_TYPE=x11

            systemctl --user import-environment \
              DBUS_SESSION_BUS_ADDRESS \
              DESKTOP_SESSION \
              DISPLAY \
              XAUTHORITY \
              XDG_CURRENT_DESKTOP \
              XDG_SESSION_DESKTOP \
              XDG_SESSION_ID \
              XDG_SESSION_TYPE || true

            dbus-update-activation-environment --systemd --all || true

            # gpg-agent can stay alive across logins with stale DISPLAY/TTY data.
            ${pkgs.gnupg}/bin/gpg-connect-agent reloadagent /bye >/dev/null 2>&1 || true
            ${pkgs.gnupg}/bin/gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1 || true

            if [ -r /etc/X11/Xresources ]; then
              ${pkgs.xrdb}/bin/xrdb -merge /etc/X11/Xresources
            fi

            ${lib.getExe' pkgs.polkit_gnome "polkit-gnome-authentication-agent-1"} &
            ${pkgs.xset}/bin/xset r rate 300 70

            # Keep a short grace period before handing control to i3.
            sleep 0.2
          '';
        };

        xkb = {
          layout = "latam,us";
          options = "grp:win_space_toggle";
        };

        autoRepeatDelay = 300;
        autoRepeatInterval = 14;

        serverFlagsSection = ''
          Option "StandbyTime" "30"
          Option "SuspendTime" "0"
          Option "OffTime" "0"
          Option "BlankTime" "0"
        '';

        windowManager.i3 = {
          enable = true;
          package = self.packages.${pkgs.stdenv.hostPlatform.system}.i3;

          extraPackages = with pkgs; [
            xclip
            bemenu
            scrot
            bluetui
            wiremix
            impala
            udiskie
            alacritty
            inputs.shtatus.packages.${pkgs.stdenv.hostPlatform.system}.default
            inputs.anypinentry.packages.${pkgs.stdenv.hostPlatform.system}.default
          ];
        };
      };

      services.libinput = {
        enable = true;
        mouse.accelProfile = "flat";
        touchpad = {
          naturalScrolling = true;
          tapping = true;
          disableWhileTyping = false;
        };
      };

      environment.etc =
        {
          "X11/Xresources".source = "${x11Dir}/Xresources";
        }
        // mkEtcEntries "X11/Xresources.d" "${x11Dir}/Xresources.d";
    };
}
