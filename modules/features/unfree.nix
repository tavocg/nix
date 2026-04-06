{ ... }: {
  flake.nixosModules.unfree = { pkgs, ... }: {
    nixpkgs.config.allowUnfree = true;
  };
}


