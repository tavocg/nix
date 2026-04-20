{ inputs, ... }: {
  flake.nixosModules.environmentPackages = { config, lib, pkgs, ... }:
    let
      cudaEnabled = lib.attrByPath [ "local" "nvidia" "cuda" "enable" ] false config;
      x11Enabled = lib.attrByPath [ "local" "x11" "enable" ] false config;
      waylandEnabled = lib.attrByPath [ "local" "wayland" "enable" ] false config;
      obsPackage =
        if cudaEnabled then
          pkgs.obs-studio.override { cudaSupport = true; }
        else
          pkgs.obs-studio;
      emacsPackage =
        if waylandEnabled then
          pkgs.emacs-pgtk
        else if x11Enabled then
          pkgs.emacs
        else
          pkgs.emacs;
    in {
      environment.systemPackages = with pkgs; [
        neovim
        yazi
        git
        trash-cli
        tmux
        jq
        imv
        vlc
        mpv
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
        obsidian
        (pass.withExtensions (exts: [exts.pass-otp]))
        lazygit
        lazydocker
        impala
        wiremix
        bluetui
        firefox
        thunderbird
        libreoffice-fresh
        gnome-disk-utility
        gimp
        kdePackages.kdenlive
        darktable
        obsPackage
        xournalpp
        zathura
        imagemagick
        exiftool
        emacsPackage
        file
        poppler-utils
        bubblewrap
        ripgrep
        fd
      ];
    };
}
