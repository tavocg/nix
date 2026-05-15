{ ... }: {
  flake.nixosModules.gamingFlightgear = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      flightgear
      opentrack
    ];
  };
}
