{ inputs, self, ... }: {
  flake.nixosModules.environmentDev = { config, lib, pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      markdownlint-cli
      gnumake
      autoconf
      automake
      binutils
      m4
      gcc
      tesseract
      pkg-config
      fakeroot
      bison
      go
      uv
    ];
  };
}
