{ inputs, ... }: {
  flake.nixosModules.environmentPackages = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      neovim
      lazygit
      lazydocker
      impala
      wiremix
      bluetui

      inputs.codex-nix.packages.${pkgs.stdenv.hostPlatform.system}.default
      bubblewrap
      ripgrep
      fd
    ];
  };
}
