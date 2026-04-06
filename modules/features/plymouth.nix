{ ... }: {
  flake.nixosModules.plymouth = { pkgs, ... }: {
    boot = {
      plymouth = {
        enable = true;
      };

      # Enable "Silent boot"
      consoleLogLevel = 3;
      initrd.verbose = false;
      kernelParams = [
        "quiet"
        "udev.log_level=3"
        "systemd.show_status=auto"
      ];

      # Hide the OS choice for bootloaders.
      # It's still possible to open the bootloader list by pressing any key
      # It will just not appear on screen unless a key is pressed
      loader.timeout = 0;

      # If you are using LUKS encryption and the password prompt falls back
      # to text mode, it may help to switch to initrd-systemd mode:
      # boot.initrd.systemd.enable = true;
    };
  };
}
