{ inputs, self, ... }: {
  perSystem = { pkgs, ... }: let
    system = pkgs.stdenv.hostPlatform.system;
  in {
    packages.shell-runtime = pkgs.buildEnv {
      name = "shell-runtime";
      paths = with pkgs; [
        git
        lazygit
        yazi
        eza
        inputs.kanban.packages.${system}.default
      ];
    };
  };

  flake.nixosModules.shellPackages = { pkgs, ... }: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.shell-runtime
    ];
  };
}
