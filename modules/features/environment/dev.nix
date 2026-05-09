{ inputs, self, ... }: {
  flake.nixosModules.environmentDev = { config, lib, pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      markdownlint-cli
      android-tools
      scrcpy
      gnumake
      autoconf
      automake
      binutils
      m4
      gcc
      cmake
      tesseract
      pkg-config
      fakeroot
      bison
      go
      uv
    ];
  };
}
