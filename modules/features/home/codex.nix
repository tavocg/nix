{ inputs, ... }: {
  flake.homeModules.codex = { pkgs, ... }: {
    home.packages = [
      inputs.codex-nix.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
