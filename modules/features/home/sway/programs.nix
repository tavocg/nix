{ inputs, pkgs, ... }:
let
  anypinentryPackage = inputs.anypinentry.packages.${pkgs.stdenv.hostPlatform.system}.default;
in {
  home.packages = [
    pkgs.sway
    pkgs.grim
    pkgs.slurp
    pkgs.wl-clipboard
    anypinentryPackage
  ];
}
