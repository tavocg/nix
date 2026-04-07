{ inputs, ... }: {
  imports = [
    inputs.wrapper-modules.flakeModules.wrappers
  ];

  flake.wrappers.bash = { config, pkgs, lib, wlib, ... }: {
    imports = [ wlib.modules.default ];

    config = let
      shellPackages = with pkgs; [
        git
        lazygit
        yazi
        eza
      ];
    in {
      package = pkgs.bashInteractive;
      passthru.shellPath = "/bin/bash";

      flags."--rcfile" = config.constructFiles.bashrc.path;

      constructFiles.bashrc = {
        relPath = "bashrc";
        content = ''
          dotfiles_root="${inputs.dotfiles}"

          export PATH="${lib.makeBinPath shellPackages}:$PATH"

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
