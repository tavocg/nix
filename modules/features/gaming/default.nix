{ self, ... }: {
  flake.nixosModules.gaming = { pkgs, ... }: {
    imports = [
      self.nixosModules.gamingMinecraft
      self.nixosModules.gamingSunshine
      self.nixosModules.gamingSteam
      self.nixosModules.gamingFlightgear
    ];

    environment.systemPackages = with pkgs; [
      lutris
    ];
  };
}
