{ self, ... }: {
  flake.nixosModules.system = { ... }: {
    imports = [
      self.nixosModules.systemAppImage
      self.nixosModules.systemBinsh
      self.nixosModules.systemCACert
      self.nixosModules.systemFonts
      self.nixosModules.systemGnuPG
      self.nixosModules.systemHosts
      self.nixosModules.systemLocaleCR
      self.nixosModules.systemPipewire
      self.nixosModules.systemPrinting
      self.nixosModules.systemPlymouth
      self.nixosModules.systemShell
      self.nixosModules.systemSSH
      self.nixosModules.systemStorage
      self.nixosModules.systemUser
      self.nixosModules.systemV4L2Loopback
      self.nixosModules.systemWindowing
    ];
  };
}
