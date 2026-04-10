{ inputs, self, ... }: {
  imports = [
    inputs.wrapper-modules.flakeModules.wrappers
  ];

  flake.wrappers.foot = { config, pkgs, wlib, ... }: let
    footConfigPath = config.constructFiles.config.path;
  in {
    imports = [ wlib.modules.default ];

    config = {
      package = pkgs.foot;

      flags."--config" = footConfigPath;

      constructFiles.config = {
        relPath = "foot.ini";
        content = builtins.readFile "${inputs.dotfiles}/foot/foot.ini";
      };
    };
  };

  perSystem = { config, ... }: {
    wrappers = {
      control_type = "build";
      packages.foot = true;
    };

    apps.foot = {
      type = "app";
      program = "${config.packages.foot}/bin/foot";
    };
  };

  flake.nixosModules.foot = { pkgs, ... }: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.foot
    ];
  };
}
