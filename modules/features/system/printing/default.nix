{ self, ... }: {
  flake.nixosModules.systemPrinting = { ... }: {
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    services.ipp-usb.enable = true;

    services.printing.enable = true;
  };
}
