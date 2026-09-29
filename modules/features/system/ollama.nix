{ ... }: {
  flake.nixosModules.systemOllama = { config, lib, pkgs, ... }:
    let
      cudaEnabled = lib.attrByPath [ "local" "gpu" "nvidia" "cuda" "enable" ] false config;
    in {
      services.ollama = {
        enable = true;
        package = if cudaEnabled then pkgs.ollama-cuda else pkgs.ollama;
      };
    };
}
