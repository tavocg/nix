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
        cups-filters
        cups-browsed
        epson-escpr2
      ];
    };
  };
}
