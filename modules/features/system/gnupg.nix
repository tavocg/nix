{ inputs, ... }: {
  flake.nixosModules.systemGnuPG = { pkgs, ... }: {
    programs.gnupg.agent = {
      enable = true;
      pinentryPackage = inputs.pinentry-bemenu.packages.${pkgs.stdenv.hostPlatform.system}.default;
    };
  };
}
