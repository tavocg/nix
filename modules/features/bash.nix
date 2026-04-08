{ inputs, ... }: {
  imports = [
    inputs.wrapper-modules.flakeModules.wrappers
  ];

  flake.wrappers.bash = { config, pkgs, wlib, ... }: let
    bashrcPath = config.constructFiles.bashrc.path;
  in {
    imports = [ wlib.modules.default ];

    config = {
      package = pkgs.bashInteractive;
      passthru.shellPath = "/bin/bash";

      flags."--rcfile" = bashrcPath;

      constructFiles.bashrc = {
        relPath = "bashrc";
        content = ''
          dotfiles_root="${inputs.dotfiles}"

          if [ -d "$dotfiles_root/profile.d" ]; then
            for profile in "$dotfiles_root"/profile.d/*; do
              if [ -f "$profile" ] && [ -r "$profile" ]; then
                . "$profile"
              fi
            done
          fi

          if [ -r "$dotfiles_root/bashrc" ]; then
            . "$dotfiles_root/bashrc"
          fi
        '';
      };
    };
  };

  perSystem = { config, ... }: {
    wrappers = {
      control_type = "build";
      packages.bash = true;
    };

    apps.bash = {
      type = "app";
      program = "${config.packages.bash}/bin/bash";
    };
  };
}
