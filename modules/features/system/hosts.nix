{ inputs, ... }: {
  flake.nixosModules.systemHosts = { lib, ... }:
    let
      hostsDir = inputs.dotfiles + "/hosts";
      hostFiles = builtins.attrNames (
        lib.filterAttrs (
          name: type:
            type == "regular"
            && lib.hasSuffix ".hosts" name
        )
        (builtins.readDir hostsDir)
      );
    in {
      networking.extraHosts = lib.concatMapStringsSep "\n" (
        file: builtins.readFile (hostsDir + "/${file}")
      ) hostFiles;
    };
}
