{ inputs, self, ... }: {
  flake.nixosModules.extraPackages = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      tectonic
      pass
      passExtensions.pass-otp
    ];
  };
}
