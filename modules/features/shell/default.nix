{ self, ... }: {
  flake.nixosModules.shell = { pkgs, ... }: {
    imports = [
    ];

    programs.bash.enable = true;

    users.defaultUserShell = self.packages.${pkgs.system}.bash;
    environment.shells = [
      "/run/current-system/sw/bin/bash"
      "${self.packages.${pkgs.system}.bash}/bin/bash"
    ];
  };
}
