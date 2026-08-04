{ ... }: {
  flake.nixosModules.packagesBase = { config, pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      # editors
      neovim
      config.local.packages.emacs

      # files
      xdg-ninja
      yazi
      trash-cli
      file

      # finance
      ledger

      # hardware
      usbutils
      bluetui

      # cli tools
      tmux
      btop
      bubblewrap
      dnsutils
      eza
      fd
      fzf
      glow
      groff
      jq
      pv
      ripgrep
      sqlite

      # documents
      mupdf-headless
      poppler-utils
      zbar
      qrencode

      # media
      ffmpeg-full
      imagemagick
      exiftool
      librsvg
      tesseract
      wiremix

      # typesetting
      pandoc
      graplang
      tectonic
      typst
      tinymist
      flex

      # mail
      impala
      isync
      mu

      # language
      ispell
      (aspellWithDicts (dicts: with dicts; [
        en
        es
        fr
        de
        pt_BR
        pt_PT
      ]))

      # archiving
      arj
      atool
      brotli
      bzip2
      cabextract
      cpio
      gzip
      gnutar
      lhasa
      libarchive
      lrzip
      lz4
      lzip
      lzop
      p7zip
      pbzip2
      pigz
      pixz
      unar
      unzip
      zip
      unrar
      xz
      zopfli
      zstd

      # misc
      (pass.withExtensions (exts: [ exts.pass-otp ]))
    ];
  };
}
