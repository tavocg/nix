{ self, ... }: {
  flake.nixosModules.shell = { pkgs, ... }: {
    imports = [
    ];

    programs.bash.enable = true;

    users.defaultUserShell = /run/current-system/sw/bin/bash;
    environment.shells = [ /run/current-system/sw/bin/bash ];
  };
}
