{ ... }: {
  flake.nixosModules.xmrig = { config, lib, pkgs, ... }:
    let
      cudaEnabled = lib.attrByPath [ "local" "nvidia" "cuda" "enable" ] false config;
    in {
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
                "loader" = "${pkgs.xmrig-cuda}/lib/libxmrig-cuda.so";
              }
            else
              false;
          "pools" = [
            {
              "url" = "pool.supportxmr.com:443";
              "user" = "43aTAGoRZyb8M7RvhtYw1pHCpHqJ2nM51W7SjuGFdVdWekzTFf9PsVTCZPexd93o234z6SSq6Ag9fUSm4cjZkwvh3rp2kqT";
              "keepalive" = true;
              "tls" = true;
            }
          ];
        };
      };
    };
}
