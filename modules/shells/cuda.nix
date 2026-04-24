{ inputs, lib, ... }:
{
  perSystem = { pkgs, system, ... }:
    let
      cudaPkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      cudaToolkit = cudaPkgs.cudaPackages.cudatoolkit;
      cudaPackage = cudaPkgs.buildEnv {
        name = "cuda";
        paths = [ cudaToolkit ];
      };
      cudaLibPath = lib.makeLibraryPath [
        cudaPkgs.stdenv.cc.cc.lib
        cudaPkgs.zlib
        cudaPkgs.glib
        cudaPkgs.libGL
        cudaToolkit
      ];
    in
    {
      packages = lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux {
        cuda = cudaPackage;
      };

      devShells = lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux {
        cuda = cudaPkgs.mkShell {
          packages = [ cudaPackage ];

          shellHook = ''
            export CUDA_PATH="${cudaToolkit}"
            export CUDA_HOME="${cudaToolkit}"
            export LD_LIBRARY_PATH="${cudaLibPath}:/run/opengl-driver/lib:/run/opengl-driver-32/lib''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"

            printf '%s\n' "CUDA shell ready."
          '';
        };
      };
    };
}
