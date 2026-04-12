{ self, ... }: {
  flake.nixosModules.system = { pkgs, ... }: {
    imports = [
      self.nixosModules.brightness
      self.nixosModules.cr
      self.nixosModules.cups
      self.nixosModules.docker
      self.nixosModules.pinentry
      self.nixosModules.pipewire
      self.nixosModules.plymouth
      self.nixosModules.storage
      self.nixosModules.user
      self.nixosModules.profile
    ];
  };
}
