{ self, ... }: {
  flake.nixosModules.system = { pkgs, ... }: {
    imports = [
      self.nixosModules.cr
      self.nixosModules.cups
      self.nixosModules.docker
      self.nixosModules.fonts
      self.nixosModules.pipewire
      self.nixosModules.plymouth
      self.nixosModules.storage
      self.nixosModules.user
    ];
  };
}
