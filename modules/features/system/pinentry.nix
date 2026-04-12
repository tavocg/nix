{ inputs, ... }: {
  flake.nixosModules.pinentry = { pkgs, ... }: {
    programs.gnupg.agent = {
      enable = true;
      pinentryPackage = inputs.anypinentry.packages.${pkgs.stdenv.hostPlatform.system}.default;
    };
  };
}
