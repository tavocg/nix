{ self, ... }: {
  flake.nixosModules.gaming = { pkgs, ... }: {
    imports = [
      self.nixosModules.gamingMinecraft
      self.nixosModules.gamingSunshine
      self.nixosModules.gamingSteam
    ];

    environment.systemPackages = with pkgs; [
      lutris
      umu-launcher
      vulkan-tools
      mangohud
    ];
  };
}
