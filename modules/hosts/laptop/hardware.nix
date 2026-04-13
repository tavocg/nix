{ ... }: {
  flake.nixosModules.laptopHardware = { config, lib, modulesPath, ... }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usb_storage" "sd_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" = {
      device = "/dev/mapper/luks-68f961e2-adae-4491-bae8-577e9ff37446";
      fsType = "ext4";
    };

    boot.initrd.luks.devices."luks-68f961e2-adae-4491-bae8-577e9ff37446".device = "/dev/disk/by-uuid/68f961e2-adae-4491-bae8-577e9ff37446";

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/1F16-EEB2";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

    swapDevices = [ ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
