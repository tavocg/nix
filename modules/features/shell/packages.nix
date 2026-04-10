{ inputs, self, ... }: {
  perSystem = { pkgs, self', ... }: {
    packages.shell-runtime = pkgs.buildEnv {
      name = "shell-runtime";
      paths = (with pkgs; [
        neovim
        lazygit
        yazi
        eza
        ripgrep
        ripgrep-all
        bat
        fd
        fzf
        jq
        trash-cli

        inputs.kanban.packages.${pkgs.stdenv.hostPlatform.system}.default

        inputs.codex-nix.packages.${pkgs.stdenv.hostPlatform.system}.default
        bubblewrap # used by codex
      ]) ++ [
        self'.packages.git
        self'.packages.tmux
      ];
    };
  };

  flake.nixosModules.shellPackages = { pkgs, ... }: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.shell-runtime
    ];
  };
}
