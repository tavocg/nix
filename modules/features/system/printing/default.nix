{ self, ... }: {
  flake.nixosModules.systemPrinting = { ... }: {
    imports = [
      self.nixosModules.systemPrintingEpsonL3150
    ];

    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    services.ipp-usb.enable = true;

    services.printing.enable = true;
  };
}
