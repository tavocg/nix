{ self, ... }: {
  perSystem = { pkgs, ... }: let
    system = pkgs.stdenv.hostPlatform.system;
  in {
    packages.shell = pkgs.writeShellScriptBin "shell" ''
      export PATH="${self.packages.${system}.shell-runtime}/bin:$PATH"
      exec "${self.packages.${system}.bash}/bin/bash" "$@"
    '';

    apps.shell = {
      type = "app";
      program = "${self.packages.${system}.shell}/bin/shell";
    };
  };

  flake.nixosModules.shell = { pkgs, ... }: {
    imports = [
      self.nixosModules.shellPackages
    ];
    users.defaultUserShell = self.packages.${pkgs.stdenv.hostPlatform.system}.bash;
    environment.shells = [
      "/run/current-system/sw/bin/bash"
      "${self.packages.${pkgs.stdenv.hostPlatform.system}.bash}/bin/bash"
    ];
  };
}
