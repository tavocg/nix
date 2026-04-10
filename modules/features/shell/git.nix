{ inputs, self, ... }: {
  imports = [
    inputs.wrapper-modules.flakeModules.wrappers
  ];

  flake.wrappers.git = { config, pkgs, wlib, ... }: let
    gitConfigPath = config.constructFiles.config.path;
  in {
    imports = [ wlib.modules.default ];

    config = {
      package = pkgs.git;

      flags."-c" = "include.path=${gitConfigPath}";

      constructFiles.config = {
        relPath = "config";
        content = builtins.readFile "${inputs.dotfiles}/git/config";
      };
    };
  };

  perSystem = { config, ... }: {
    wrappers = {
      control_type = "build";
      packages.git = true;
    };

    apps.git = {
      type = "app";
      program = "${config.packages.git}/bin/git";
    };
  };

  flake.nixosModules.git = { pkgs, ... }: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.git
    ];
  };
}
