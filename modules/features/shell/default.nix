{ self, ... }: {
  flake.nixosModules.shell = { pkgs, ... }: let
    bashPackage = self.packages.${pkgs.stdenv.hostPlatform.system}.bash;
  in {
    imports = [
    ];

    users.defaultUserShell = bashPackage;
    environment.shells = [
      "/run/current-system/sw/bin/bash"
      "${bashPackage}/bin/bash"
    ];
  };
}
