{ self, ... }: {
  flake.nixosModules.gaming = { ... }: {
    imports = [
      self.nixosModules.gamingMinecraft
      self.nixosModules.gamingSunshine
      self.nixosModules.gamingSteam
      self.nixosModules.gamingFlightgear
    ];
  };
}
