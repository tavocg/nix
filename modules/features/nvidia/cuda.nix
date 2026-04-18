{ ... }: {
  flake.nixosModules.nvidiaCuda = { config, lib, pkgs, ... }:
    let
      cfg = config.local.nvidia.cuda;
    in {
      options.local.nvidia.cuda.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable CUDA tooling and CUDA-aware package overrides.";
      };

      config = lib.mkIf cfg.enable {
        # Keep CUDA tooling explicit. Enabling nixpkgs.config.cudaSupport globally
        # rebuilds a large part of the package set with CUDA enabled and can OOM
        # local machine builds.
        environment.systemPackages = with pkgs.cudaPackages; [
          cuda_nvcc
          cuda_cudart
        ];
      };
    };
}
