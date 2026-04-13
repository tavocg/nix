{ inputs, ... }: {
  flake.nixosModules.environmentPackages = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      neovim
      yazi
      lazygit
      lazydocker
      impala
      wiremix
      bluetui
      eza

      inputs.codex-nix.packages.${pkgs.stdenv.hostPlatform.system}.default
      bubblewrap
      ripgrep
      fd
    ];
  };
}
