{ inputs, pkgs, ... }: {
  home.packages = [
    pkgs.sway
    pkgs.grim
    pkgs.slurp
    pkgs.wl-clipboard
    inputs.anypinentry.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
