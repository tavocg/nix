{ inputs, self, ... }: {
  flake.nixosModules.environmentPackages = { config, lib, pkgs, ... }: {
    imports = [
      self.nixosModules.obs
      self.nixosModules.emacs
      # self.nixosModules.nautilus
    ];

    environment.systemPackages =
      with pkgs;
      [
        neovim
        yazi
        git
        trash-cli
        tmux
        jq
        eza
        markdownlint-cli
        ffmpeg-full
        gnumake
        autoconf
        automake
        binutils
        m4
        gcc
        tesseract
        pkg-config
        fakeroot
        flex
        bison
        tectonic
        inputs.kanban.packages.${pkgs.stdenv.hostPlatform.system}.default
        glow
        pandoc
        (pass.withExtensions (exts: [ exts.pass-otp ]))
        lazygit
        lazydocker
        impala
        wiremix
        bluetui
        imagemagick
        exiftool
        config.local.environment.packages.emacs
        file
        inputs.codex-nix.packages.${pkgs.stdenv.hostPlatform.system}.default
        poppler-utils
        bubblewrap
        ripgrep
        fd
      ]
      ++ lib.optionals (config.local.x11.enable || config.local.wayland.enable) [
        imv
        vlc
        mpv
        obsidian
        firefox
        thunderbird
        libreoffice-fresh
        gnome-disk-utility
        gimp
        kdePackages.kdenlive
        darktable
        config.local.environment.packages.obs
        # config.local.environment.packages.nautilus
        # libheif
        # libheif.out
        xournalpp
        zathura
      ];
  };
}
