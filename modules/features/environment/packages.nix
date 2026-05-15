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
        zbar
        qrencode
        eza
        btop
        fzf
        ffmpeg-full
        tesseract
        flex
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
        poppler-utils
        bubblewrap
        ripgrep
        fd
      ];
  };
}
