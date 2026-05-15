{ ... }: {
  flake.nixosModules.gamingSteam = { ... }: {
    programs.steam.enable = true;
  };
}
