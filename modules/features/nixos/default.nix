{ self, ... }: {
  flake.nixosModules.nixos = { pkgs, ... }: {
    imports = [
      self.nixosModules.flakes
      self.nixosModules.unfree
    ];

    nix.settings.use-xdg-base-directories = true;
  };
}
