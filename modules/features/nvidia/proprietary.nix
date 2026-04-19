{ self, ... }: {
  # Note: this would work in desktop but not in a laptop,
  # for laptop create something like nvidiaProprietaryPrime
  flake.nixosModules.nvidiaProprietary = { config, ... }: {
    hardware.graphics.enable = true;

    services.xserver.videoDrivers = ["nvidia"]; # (Xorg and Wayland)

    hardware.graphics.enable32Bit = true;

    hardware.nvidia = {
      modesetting.enable = true;

      # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      # Enable this if you have graphical corruption issues or application crashes after waking
      # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
      # of just the bare essentials.
      powerManagement.enable = false;

      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      powerManagement.finegrained = false;

      # Use the NVidia open source kernel module (not to be confused with the
      # independent third-party "nouveau" open source driver).
      # Support is limited to the Turing and later architectures. Full list of 
      # supported GPUs is at: 
      # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
      # Only available from driver 515.43.04+
      open = false;

      nvidiaSettings = true; # Nvidia settings menu,

      # GTX 1060 (Pascal) is supported by the 580 legacy branch, not the current stable branch.
      package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
    };
  };
}
