{ inputs, self, ... }: {
  imports = [
    inputs.wrapper-modules.flakeModules.wrappers
  ];

  flake.wrappers.i3 = { config, pkgs, wlib, ... }: let
    i3ConfigPath = config.constructFiles.config.path;
  in {
    imports = [ wlib.modules.default ];

    config = {
      package = pkgs.i3;

      flags."-c" = i3ConfigPath;

      constructFiles.config = {
        relPath = "config";
        content = builtins.readFile "${inputs.dotfiles}/i3/config";
      };
    };
  };

  perSystem = { config, ... }: {
    wrappers = {
      control_type = "build";
      packages.i3 = true;
    };

    apps.i3 = {
      type = "app";
      program = "${config.packages.i3}/bin/i3";
    };
  };

  flake.nixosModules.i3 = { pkgs, ... }: {
    services.xserver = {
      enable = true;
      windowManager.i3 = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.i3;

        extraPackages = with pkgs; [
          xclip
          bemenu
          scrot
          bluetui
          wiremix
          impala
          alacritty
          inputs.shtatus.packages.${pkgs.stdenv.hostPlatform.system}.default
          inputs.anypinentry.packages.${pkgs.stdenv.hostPlatform.system}.default
        ];
      };
    };
  };
}
