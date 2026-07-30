{ ... }: {
  flake.nixosModules.gamingSteam = { ... }: {
    programs = {
      gamescope = {
        enable = true;
        capSysNice = false; # should be true but bwrap complains
      };

      steam = {
        enable = true;
        # gamescopeSession.enable = true;
      };
    };
  };
}
