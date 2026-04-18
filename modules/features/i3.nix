{ self, inputs, ... }: {
  flake.nixosModules.i3 = { pkgs, ... }: {
    imports = [
      self.nixosModules.x
    ];

    environment.systemPackages = [
      pkgs.xclip
      pkgs.bemenu
      pkgs.scrot
      pkgs.xcolor
      pkgs.xdotool
      inputs.st.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.shtatus.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    services.xserver = {
      enable = true;

      displayManager.startx.enable = true;

      windowManager.i3.enable = true;
    };
  };
}
