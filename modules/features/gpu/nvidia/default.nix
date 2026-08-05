{ ... }: {
  flake.nixosModules.gpuNvidia = { lib, ... }: {
    options.local.gpu.nvidia.enable = lib.mkEnableOption "NVIDIA GPU configuration";
  };
}
