{ inputs, ... }: {
  flake.nixosModules.i3 = { pkgs, ... }: {
    environment.systemPackages = [
      inputs.st.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

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
