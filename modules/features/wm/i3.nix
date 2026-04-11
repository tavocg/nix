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
      lxpolkitPackages =
        lib.optionals (lib.hasAttrByPath [ "lxqt" "lxqt-policykit" ] pkgs) [ pkgs.lxqt.lxqt-policykit ]
        ++ lib.optionals (pkgs ? lxpolkit) [ pkgs.lxpolkit ];

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
          # generateScript = true; # Re-enable if NixOS's generated startx/xinit integration is needed.
        };

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
          ] ++ lxpolkitPackages;
        };
      };

      environment.etc =
        {
          "X11/Xresources".source = "${x11Dir}/Xresources";
        }
        // mkEtcEntries "X11/Xresources.d" "${x11Dir}/Xresources.d";
    };
}
