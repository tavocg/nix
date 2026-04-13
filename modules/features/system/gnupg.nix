{ inputs, ... }: {
  flake.nixosModules.gnupg = { pkgs, ... }: {
    programs.gnupg.agent = {
      enable = true;
      pinentryPackage = inputs.pinentry-bemenu.packages.${pkgs.stdenv.hostPlatform.system}.default;
    };
  };
}
