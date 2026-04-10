{ inputs, self, ... }: {
  imports = [
    inputs.wrapper-modules.flakeModules.wrappers
  ];

  flake.wrappers.tmux = { config, pkgs, wlib, ... }: let
    tmuxConfigPath = config.constructFiles.tmuxConf.path;
  in {
    imports = [ wlib.modules.default ];

    config = {
      package = pkgs.tmux;

      flags."-f" = tmuxConfigPath;

      constructFiles.tmuxConf = {
        relPath = "tmux.conf";
        content = builtins.readFile "${inputs.dotfiles}/tmux/tmux.conf";
      };
    };
  };

  perSystem = { config, ... }: {
    wrappers = {
      control_type = "build";
      packages.tmux = true;
    };

    apps.tmux = {
      type = "app";
      program = "${config.packages.tmux}/bin/tmux";
    };
  };

  flake.nixosModules.tmux = { pkgs, ... }: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.tmux
    ];
  };
}
