{ ... }: {
  flake.nixosModules.systemV4L2Loopback = { config, ... }: {
    boot.extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];

    boot.kernelModules = [
      "v4l2loopback"
    ];
  };
}
