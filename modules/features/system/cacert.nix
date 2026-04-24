{ inputs, self, ... }: {
  flake.nixosModules.cacert = { config, lib, pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      cacert
    ];
  };
}
