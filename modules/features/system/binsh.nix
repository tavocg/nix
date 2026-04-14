{ ... }: {
  flake.nixosModules.binsh = { pkgs, ... }: {
    environment.binsh = "${pkgs.dash}/bin/dash";
  };
}

