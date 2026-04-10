{ inputs, self, ... }: {
  flake.nixosModules.extraPackages = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      tectonic
      (pass.withExtensions (exts: [ exts.pass-otp ]))
    ];
  };
}
