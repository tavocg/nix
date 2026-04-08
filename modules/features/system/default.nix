{ self, ... }: {
  flake.nixosModules.system = { pkgs, ... }: {
    imports = [
      self.nixosModules.brightness
      self.nixosModules.cr
      self.nixosModules.cups
      self.nixosModules.fonts
      self.nixosModules.pinentry
      self.nixosModules.pipewire
      self.nixosModules.plymouth
      self.nixosModules.storage
      self.nixosModules.tavo
    ];
  };
}
