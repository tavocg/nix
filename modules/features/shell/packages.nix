{ inputs, self, ... }: {
  perSystem = { pkgs, ... }: {
    packages.shell-runtime = pkgs.buildEnv {
      name = "shell-runtime";
      paths = with pkgs; [
        git
        lazygit
        yazi
        eza
        ripgrep-all
        bat
        fd
        fzf

        inputs.kanban.packages.${pkgs.stdenv.hostPlatform.system}.default

        inputs.codex-nix.packages.${pkgs.stdenv.hostPlatform.system}.default
        bubblewrap # used by codex
      ];
    };
  };

  flake.nixosModules.shellPackages = { pkgs, ... }: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.shell-runtime
    ];
  };
}
