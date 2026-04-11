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

  perSystem = { config, pkgs, ... }: let
    dotfilesXinitrc = "${inputs.dotfiles}/X11/xinit/xinitrc";
    dotfilesXorgConfigDir = "${inputs.dotfiles}/X11/xorg.conf.d";
  in {
    wrappers = {
      control_type = "build";
      packages.i3 = true;
    };

    packages.startx = pkgs.writeShellScriptBin "startx" ''
      export XINITRC="${dotfilesXinitrc}"

      has_server_args=0
      for arg in "$@"; do
        if [ "$arg" = "--" ]; then
          has_server_args=1
          break
        fi
      done

      if [ "$has_server_args" -eq 1 ]; then
        exec ${pkgs.xorg.xinit}/bin/startx "$@"
      fi

      exec ${pkgs.xorg.xinit}/bin/startx "$@" -- :0 -configdir "${dotfilesXorgConfigDir}"
    '';

    apps.i3 = {
      type = "app";
      program = "${config.packages.i3}/bin/i3";
    };

    apps.startx = {
      type = "app";
      program = "${config.packages.startx}/bin/startx";
    };
  };

  flake.nixosModules.i3 = { pkgs, ... }: {
    imports = [
      self.nixosModules.foot
    ];

    services.xserver = {
      enable = true;
      excludePackages = [ pkgs.xterm ];

      displayManager.startx.enable = true;

      windowManager.i3 = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.i3;

        extraPackages = with pkgs; [
          bemenu
          bluetui
          feh
          picom
          wiremix
          xclip
          xss-lock
          inputs.shtatus.packages.${pkgs.stdenv.hostPlatform.system}.default
          inputs.anypinentry.packages.${pkgs.stdenv.hostPlatform.system}.default
        ] ++ [
          self.packages.${pkgs.stdenv.hostPlatform.system}.foot
        ];
      };
    };

    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.startx
    ];
  };
}
