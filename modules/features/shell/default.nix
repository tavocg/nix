{ self, ... }: {
  flake.nixosModules.shell = { pkgs, ... }: {
    users.defaultUserShell = self.packages.${pkgs.stdenv.hostPlatform.system}.bash;
    environment.shells = [
      "/run/current-system/sw/bin/bash"
      "${self.packages.${pkgs.stdenv.hostPlatform.system}.bash}/bin/bash"
    ];
  };
}
