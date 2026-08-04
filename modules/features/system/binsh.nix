{ ... }: {
  flake.nixosModules.systemBinsh = { pkgs, ... }: {
    environment.binsh = "${pkgs.dash}/bin/dash";
  };
}
