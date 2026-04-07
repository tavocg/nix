{ self, ... }: {
  flake.nixosModules.shell = { pkgs, ... }: {
    imports = [
      self.nixosModules.bash
    ];

    users.defaultUserShell = self.packages.${pkgs.stdenv.hostPlatform.system}.bash;
    environment.shells = [
      "/run/current-system/sw/bin/bash"
      "${self.packages.${pkgs.stdenv.hostPlatform.system}.bash}/bin/bash"
    ];
  };
}
