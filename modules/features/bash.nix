{ inputs, ... }: {
  imports = [
    inputs.wrapper-modules.flakeModules.default
  ];

  flake.wrappers.bash = { config, pkgs, wlib, ... }: {
    imports = [ wlib.modules.default ];

    package = pkgs.bashInteractive;

    flags."--rcfile" = config.constructFiles.bashrc.path;

    constructFiles.bashrc = {
      relPath = "bashrc";
      content = ''
        dotfiles_root="${inputs.dotfiles}"

        if [ -d "$dotfiles_root/profile.d" ]; then
          for profile in "$dotfiles_root"/profile.d/*; do
            if [ -r "$profile" ]; then
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
