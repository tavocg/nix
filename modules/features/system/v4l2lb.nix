{ ... }: {
  flake.nixosModules.v4l2lb = { config, ... }: {
    boot.extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];

    boot.kernelModules = [
      "v4l2loopback"
    ];
  };
}
