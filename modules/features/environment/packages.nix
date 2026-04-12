{ inputs, self, ... }: {
  flake.nixosModules.environmentPackages = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      # core / system
      # xdg-desktop-portal
      # xdg-desktop-portal-gtk
      # glib
      # lxqt.lxqt-policykit
      # polkit
      gnome.gnome-disk-utility
      upower
      ffmpeg-full
      fuse

      # programs
      firefox
      libreoffice-fresh
      zathura
      mpv
      vlc
      imv
      kdePackages.kdenlive
      obs-studio
      darktable
      gimp
      xournalpp

      # cli tools
      # yazi
      # trash-cli
      # unzip
      # nnn
      # exiftool
      # zoxide
      # p7zip
      # rsync
      # resvg
      curl
      fzf
      eza
      fd
      ripgrep
      tectonic
      (pass.withExtensions (exts: [ exts.pass-otp ]))
      zbar
      imagemagick
      tmux
      bat
      tokei
      groff
      git
      lazygit
      shellcheck
      jq
      android-tools
      btop
      python3
      ledger

      # dev
      # R
      # gcc
      # gnumake
      # rustup
      # ruby
      # jdk
      # jre
      # markdownlint-cli
      # glow
      # rPackages.data_table
      # rPackages.openxlsx
      # rPackages.knitr
      # rPackages.rmarkdown
      # rPackages.tinytex

      # extra
      corefonts
      gnome.gnome-themes-extra
    ];

    fonts.packages = with pkgs; [
      jetbrains-mono
      nerd-fonts.jetbrains-mono
    ];
  };
}
