{ self, ... }: {
  flake.nixosModules.shell = { pkgs, ... }: {
    imports = [
    ];

    programs.bash.enable = true;

    users.defaultUserShell = self.packages.${pkgs.system}.bash;
    environment.shells = [ self.packages.${pkgs.system}.bash ];
  };
}
