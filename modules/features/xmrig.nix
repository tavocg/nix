{ ... }: {
  flake.nixosModules.xmrig =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      cudaEnabled = lib.attrByPath [ "local" "gpu" "nvidia" "cuda" "enable" ] false config;
      cudaArches = lib.attrByPath [ "local" "gpu" "nvidia" "cuda" "arches" ] [ ] config;
      cudaPackages = lib.attrByPath [ "local" "gpu" "nvidia" "cuda" "packages" ] pkgs.cudaPackages config;

      # Build against the same CUDA set as the other local CUDA packages, and
      # only for the local GPU's compute capability. Upstream defaults to
      # CUDA_ARCH=50, which the pinned CUDA 12.6 nvcc supports but the default
      # CUDA 13 nvcc (used by pkgs.xmrig-cuda) does not, since it dropped
      # Maxwell/Pascal.
      xmrigCuda = (pkgs.xmrig-cuda.override { inherit cudaPackages; }).overrideAttrs (old: {
        cmakeFlags =
          (old.cmakeFlags or [ ])
          ++ lib.optional (cudaArches != [ ]) "-DCUDA_ARCH=${lib.concatStringsSep ";" cudaArches}";
      });
    in
    {
      services.xmrig = {
        enable = true;
        settings = {
          "autosave" = true;
          "cpu" = {
            "enabled" = true;
            "rx" = [
              (-1)
              (-1)
            ];
            "rx/wow" = [
              (-1)
              (-1)
            ];
          };
          "opencl" = false;
          "cuda" =
            if cudaEnabled then
              {
                "enabled" = true;
                "loader" = "${xmrigCuda}/lib/libxmrig-cuda.so";
              }
            else
              false;
          "pools" = [
            {
              "url" = "pool.hashvault.pro:443";
              "user" =
                "43aTAGoRZyb8M7RvhtYw1pHCpHqJ2nM51W7SjuGFdVdWekzTFf9PsVTCZPexd93o234z6SSq6Ag9fUSm4cjZkwvh3rp2kqT";
              "pass" = config.networking.hostName;
              "rig-id" = config.networking.hostName;
              "keepalive" = false;
              "tls" = true;
            }
          ];
        };
      };

      # Keep the unit installed but not enabled at boot by default.
      systemd.services.xmrig.wantedBy = lib.mkForce [ ];
    };
}
