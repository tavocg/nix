{ inputs, ... }: {
  flake.nixosModules.pinentry = { pkgs, ... }: let
    anypinentry = inputs.anypinentry.packages.${pkgs.stdenv.hostPlatform.system}.default;
  in {
    programs.gnupg.agent = {
      enable = true;
      pinentryPackage = anypinentry;
    };
  };
}
