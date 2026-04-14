{ self, ... }: {
  flake.nixosModules.system = { ... }: {
    imports = [
      self.nixosModules.cr
      self.nixosModules.cups
      self.nixosModules.docker
      self.nixosModules.fonts
      self.nixosModules.gnupg
      self.nixosModules.pipewire
      self.nixosModules.plymouth
      self.nixosModules.shell
      self.nixosModules.ssh
      self.nixosModules.storage
      self.nixosModules.user
    ];
  };
}
