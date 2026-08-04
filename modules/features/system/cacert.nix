{ inputs, self, ... }: {
  flake.nixosModules.systemCACert = { config, lib, pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      cacert
    ];
  };
}
