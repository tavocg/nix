{ ... }: {
  flake.nixosModules.gpuNvidiaCUDA = { lib, ... }: {
    options.local.gpu.nvidia.cuda.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable CUDA-aware package overrides.";
    };
  };
}
