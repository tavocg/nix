{ inputs, ... }: {
  flake.nixosModules.environmentPackages = { pkgs, ... }: {
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
      gnumake
      inputs.kanban.packages.${pkgs.stdenv.hostPlatform.system}.default
      glow
      (pass.withExtensions (exts: [exts.pass-otp]))
      lazygit
      lazydocker
      impala
      wiremix
      bluetui
      firefox
      libreoffice-fresh
      gnome-disk-utility
      gimp
      kdePackages.kdenlive
      darktable
      obs-studio
      xournalpp
      zathura
      imagemagick
      file
      inputs.codex-nix.packages.${pkgs.stdenv.hostPlatform.system}.default
      bubblewrap
      ripgrep
      fd
    ];
  };
}
