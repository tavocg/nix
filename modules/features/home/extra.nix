{ inputs, ... }: {
  flake.homeModules.codex = { pkgs, ... }: {
    home.packages = [
      inputs.codex-nix.packages.${pkgs.stdenv.hostPlatform.system}.default
    ] ++ (with pkgs; [
      gnome-disk-utility
      upower
      ffmpeg-full
      fuse
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
      neovim
      curl
      fzf
      eza
      fd
      ripgrep
      tectonic
      zbar
      imagemagick
      tmux
      bat
      tokei
      groff
      lazygit
      shellcheck
      jq
      android-tools
      btop
      python3
      ledger
      gnome-themes-extra
      yazi
      trash-cli
    ]);
  };
}
