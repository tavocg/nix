{ inputs, ... }: {
  flake.nixosModules.x = { lib, ... }:
    let
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
      services.libinput.enable = true;

      services.xserver.extraConfig = lib.concatMapStringsSep "\n\n" (
        file: builtins.readFile (xorgConfDir + "/${file}")
      ) xorgConfFiles;
    };
}
