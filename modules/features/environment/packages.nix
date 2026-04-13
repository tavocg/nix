{ inputs, ... }: {
  flake.nixosModules.environmentPackages = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      neovim
      yazi
      git
      lazygit
      lazydocker
      impala
      wiremix
      bluetui
      eza
      firefox

      inputs.codex-nix.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.kanban.packages.${pkgs.stdenv.hostPlatform.system}.default
      bubblewrap
      ripgrep
      fd
    ];
  };
}
