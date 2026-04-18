{ inputs, ... }: {
  flake.nixosModules.windowing = { config, lib, ... }:
    let
      x11Enabled = config.local.x11.enable;
      waylandEnabled = config.local.wayland.enable;
      xorgConfDir = inputs.dotfiles + "/X11/xorg.conf.d";
      xorgConfFiles = builtins.attrNames (
        lib.filterAttrs (
          name: type:
            type == "regular"
            && lib.hasSuffix ".conf" name
        )
        (builtins.readDir xorgConfDir)
      );
    in {
      options.local = {
        x11.enable = lib.mkEnableOption "X11-specific local configuration";
        wayland.enable = lib.mkEnableOption "Wayland-specific local configuration";
      };

      config = lib.mkMerge [
        {
          assertions = [
            {
              assertion = !(x11Enabled && waylandEnabled);
              message = "local.x11.enable and local.wayland.enable cannot both be enabled.";
            }
          ];
        }
        (lib.mkIf x11Enabled {
          services.libinput.enable = true;

          services.xserver.extraConfig = lib.concatMapStringsSep "\n\n" (
            file: builtins.readFile (xorgConfDir + "/${file}")
          ) xorgConfFiles;
        })
      ];
    };
}
