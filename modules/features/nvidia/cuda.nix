{ ... }: {
  flake.nixosModules.nvidiaCuda = { pkgs, ... }: {
    # Keep CUDA tooling explicit. Enabling nixpkgs.config.cudaSupport globally
    # rebuilds a large part of the package set with CUDA enabled and can OOM
    # local machine builds.
    environment.systemPackages = with pkgs.cudaPackages; [
      cuda_nvcc
      cuda_cudart
    ];
  };
}
