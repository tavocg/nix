{ ... }: {
  flake.nixosModules.i3 = { ... }: {
    services.xserver = {
      enable = true;

      displayManager.startx = {
        enable = true;
        generateScript = true;
      };

      windowManager.i3.enable = true;
    };
  };
}
