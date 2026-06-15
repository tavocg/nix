{ inputs, self, ... }: {
  flake.nixosModules.environmentDev = { config, lib, pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      markdownlint-cli
      androidenv.androidPkgs.platform-tools
      scrcpy
      gnumake
      autoconf
      automake
      binutils
      m4
      gcc
      clang-tools
      cmake
      cppcheck
      cpplint
      tesseract
      pkg-config
      fakeroot
      bison
      go
      gopls
      golangci-lint
      hugo
      typescript-language-server
      vscode-langservers-extracted
      pyright
      ruff
      uv
      upx
      R
      tokei
      shellcheck
    ];
  };
}
