{ ... }: {
  flake.nixosModules.gpuNvidia = { lib, ... }: {
    options.local.gpu.nvidia.enable = lib.mkEnableOption "NVIDIA GPU configuration";

    options.local.gpu.nvidia.cuda.arches = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "CUDA architectures to compile local GPU packages for.";
    };
  };
}
