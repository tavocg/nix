{ self, inputs, ... }: {
  flake.nixosModules.hosts = { lib, ... }:
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

  flake.nixosModules.system = { ... }: {
    imports = [
      self.nixosModules.binsh
      self.nixosModules.cr
      self.nixosModules.cups
      self.nixosModules.docker
      self.nixosModules.fonts
      self.nixosModules.gnupg
      self.nixosModules.hosts
      self.nixosModules.pipewire
      self.nixosModules.plymouth
      self.nixosModules.shell
      self.nixosModules.storage
      self.nixosModules.user
    ];
  };
}
