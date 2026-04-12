{ self, inputs, ... }: {
  flake.nixosModules.desktopHardware = { config, lib, pkgs, modulesPath, ... }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" = {
      device = "/dev/mapper/luks-19ff8ef6-830b-45b4-acef-0c8ac693360d";
      fsType = "ext4";
    };

    boot.initrd.luks.devices."luks-19ff8ef6-830b-45b4-acef-0c8ac693360d".device = "/dev/disk/by-uuid/19ff8ef6-830b-45b4-acef-0c8ac693360d";

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/0321-DD81";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

    swapDevices = [ ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}

