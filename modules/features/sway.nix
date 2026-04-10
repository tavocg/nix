{ inputs, self, ... }: {
  imports = [
    inputs.wrapper-modules.flakeModules.wrappers
  ];

  flake.wrappers.sway = { config, pkgs, wlib, ... }: let
    swayConfigPath = config.constructFiles.config.path;
  in {
    imports = [ wlib.modules.default ];

    config = {
      package = pkgs.sway;

      flags."--config" = swayConfigPath;

      constructFiles.config = {
        relPath = "config";
        content = builtins.readFile "${inputs.dotfiles}/sway/config";
      };
    };
  };

  perSystem = { config, ... }: {
    wrappers = {
      control_type = "build";
      packages.sway = true;
    };

    apps.sway = {
      type = "app";
      program = "${config.packages.sway}/bin/sway";
    };
  };

  flake.nixosModules.sway = { pkgs, ... }: {
    programs.sway = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.sway;
      wrapperFeatures.gtk = true;

      extraPackages = with pkgs; [
        foot
        wl-clipboard
        bemenu
        slurp
        grim
        inputs.shtatus.packages.${pkgs.stdenv.hostPlatform.system}.default
        inputs.anypinentry.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };
  };
}
