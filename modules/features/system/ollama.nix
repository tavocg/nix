{ ... }: {
  flake.nixosModules.systemOllama = { config, lib, pkgs, ... }:
    let
      cudaEnabled = lib.attrByPath [ "local" "gpu" "nvidia" "cuda" "enable" ] false config;
      cudaArches = lib.attrByPath [ "local" "gpu" "nvidia" "cuda" "arches" ] [ ] config;
      cudaPackages = lib.attrByPath [ "local" "gpu" "nvidia" "cuda" "packages" ] pkgs.cudaPackages config;
    in {
      services.ollama = {
        enable = true;
        host = "0.0.0.0";
        openFirewall = true;
        package =
          if cudaEnabled then
            pkgs.ollama-cuda.override (
              { inherit cudaPackages; }
              // lib.optionalAttrs (cudaArches != [ ]) { inherit cudaArches; }
            )
          else
            pkgs.ollama;
      };
    };
}
