{ ... }: {
  flake.nixosModules.nvidiaCuda = { config, ... }: {
    nixpkgs.config.cudaSupport = true;
  };
}

