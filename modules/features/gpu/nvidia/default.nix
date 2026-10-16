{ ... }: {
  flake.nixosModules.gpuNvidia = { lib, pkgs, ... }: {
    options.local.gpu.nvidia.enable = lib.mkEnableOption "NVIDIA GPU configuration";

    options.local.gpu.nvidia.cuda.arches = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "CUDA architectures to compile local GPU packages for.";
    };

    options.local.gpu.nvidia.cuda.packages = lib.mkOption {
      type = lib.types.attrs;
      default = pkgs.cudaPackages;
      description = ''
        CUDA package set used to build local CUDA-aware packages (ollama,
        sunshine, ...). Pin an older release for GPUs whose compute capability
        is no longer supported by the nixpkgs default (e.g. Pascal needs CUDA 12).
      '';
    };
  };
}
