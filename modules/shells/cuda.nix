{ inputs, lib, ... }:
let
  mkCudaShell =
    system:
    let
      pkgs = import inputs.nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          cudaSupport = true;
        };
      };

      cudaPackages =
        if builtins.hasAttr "cudaPackages_12_6" pkgs then
          pkgs.cudaPackages_12_6
        else
          pkgs.cudaPackages;

      cudaLibPath = pkgs.lib.makeLibraryPath [
        pkgs.stdenv.cc.cc
        cudaPackages.cudatoolkit
        cudaPackages.cudnn
      ];
    in
    pkgs.mkShell {
      name = "cuda-shell";

      packages = [
        pkgs.gcc
        cudaPackages.cudatoolkit
        cudaPackages.cudnn
      ];

      shellHook = ''
        export CUDA_PATH=${cudaPackages.cudatoolkit}
        export CUDA_HOME=$CUDA_PATH
        export CUDA_ROOT=$CUDA_PATH
        export CUDAToolkit_ROOT=$CUDA_PATH
        export CUDNN_ROOT=${cudaPackages.cudnn}
        export CUDNN_PATH=$CUDNN_ROOT

        export CC=${pkgs.gcc}/bin/gcc
        export CXX=${pkgs.gcc}/bin/g++
        export CUDAHOSTCXX=$CXX
        export CUDACXX=$CUDA_PATH/bin/nvcc

        export LD_LIBRARY_PATH=${cudaLibPath}:''${LD_LIBRARY_PATH:-}
        export LIBRARY_PATH=${cudaLibPath}:''${LIBRARY_PATH:-}
        export CPATH=$CUDA_PATH/include:$CUDNN_ROOT/include:''${CPATH:-}
        export CMAKE_PREFIX_PATH=$CUDA_PATH:$CUDNN_ROOT:''${CMAKE_PREFIX_PATH:-}
        export CMAKE_LIBRARY_PATH=$CUDA_PATH/lib/stubs:$CUDA_PATH/lib64/stubs:''${CMAKE_LIBRARY_PATH:-}
      '';
    };
in
{
  perSystem = { system, ... }: {
    devShells = lib.optionalAttrs (system == "x86_64-linux") {
      cuda = mkCudaShell system;
    };
  };
}
