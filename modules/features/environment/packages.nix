{ inputs, self, ... }: {
  flake.nixosModules.environmentPackages = { config, lib, pkgs, ... }: {
    imports = [
      self.nixosModules.obs
      self.nixosModules.emacs
      # self.nixosModules.nautilus
    ];

    environment.systemPackages =
      let
        pkgs-2605 = import inputs.nixpkgs-2605 {
          system = pkgs.stdenv.hostPlatform.system;
        };
      in
      with pkgs;
      [
        neovim
        xdg-ninja
        yazi
        git
        trash-cli
        tmux
        jq
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
        zbar
        qrencode
        mupdf-headless
        sqlite
        eza
        btop
        fzf
        pv
        ffmpeg-full
        librsvg
        tesseract
        flex
        tectonic
        glow
        pandoc
        (pass.withExtensions (exts: [ exts.pass-otp ]))
        lazygit
        lazydocker
        isync
        pkgs-2605.mu
        impala
        wiremix
        bluetui
        imagemagick
        exiftool
        config.local.environment.packages.emacs
        file
        poppler-utils
        bubblewrap
        ripgrep
        fd
        dnsutils
        groff
        graplang
        typst
        tinymist
        ispell
        (aspellWithDicts (dicts: with dicts; [
          en
          es
          fr
          de
          pt_BR
          pt_PT
        ]))
      ];
  };
}
