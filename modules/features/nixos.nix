{ ... }: {
  flake.nixosModules.nixos = { ... }: {
    nixpkgs.config.allowUnfree = true;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nix.settings.use-xdg-base-directories = true;

    # research this later?
    programs.nix-ld.enable = true;
  };
}
