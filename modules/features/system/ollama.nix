{ ... }: {
  flake.nixosModules.systemOllama = { config, lib, pkgs, ... }:
    let
      cudaEnabled = lib.attrByPath [ "local" "gpu" "nvidia" "cuda" "enable" ] false config;
      cudaArches = lib.attrByPath [ "local" "gpu" "nvidia" "cuda" "arches" ] [ ] config;
    in {
      services.ollama = {
        enable = true;
        host = "0.0.0.0";
        openFirewall = true;
        package =
          if cudaEnabled then
            if cudaArches != [ ] then
              pkgs.ollama-cuda.override { inherit cudaArches; }
            else
              pkgs.ollama-cuda
          else
            pkgs.ollama;
      };
    };
}
