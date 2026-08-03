{ ... }: {
  flake.nixosModules.nvidiaCuda = { lib, ... }: {
    options.local.nvidia.cuda.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable CUDA-aware package overrides.";
    };
  };
}
