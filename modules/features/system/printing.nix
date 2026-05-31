{ ... }: {
  flake.nixosModules.printing = { pkgs, ... }: {
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    services.ipp-usb.enable = true;

    services.printing = {
      enable = true;
      drivers = with pkgs; [
        epson-escpr
      ];
    };

    hardware.printers = {
      ensurePrinters = [
        {
          name = "Epson_L3150";
          description = "Epson L3150 Series";
          location = "Home";

          #deviceUri = "socket://192.168.100.91:9100";
          deviceUri = "dnssd://EPSON%20L3150%20Series._pdl-datastream._tcp.local/";

          model = "epson-inkjet-printer-escpr/Epson-L3150_Series-epson-escpr-en.ppd";
        }
      ];
    };
  };
}
