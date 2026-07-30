{ ... }:
let
  usbipCommon = { config, ... }: {
    environment.systemPackages = [
      config.boot.kernelPackages.usbip
    ];
  };
in {
  flake.nixosModules.usbipHost = { ... }: {
    imports = [ usbipCommon ];

    boot.kernelModules = [
      "usbip_host"
    ];

    networking.firewall.allowedTCPPorts = [
      3240
    ];
  };

  flake.nixosModules.usbipClient = { ... }: {
    imports = [ usbipCommon ];

    boot.kernelModules = [
      "vhci_hcd"
    ];
  };
}
