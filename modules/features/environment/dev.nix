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
      # Avoid Python 3.14 test regressions in nixos-unstable.
      (import inputs.nixpkgs-2605 {
        system = pkgs.stdenv.hostPlatform.system;
      }).cpplint
      tesseract
      pkg-config
      fakeroot
      bison
      go
      gopls
      golangci-lint
      gomodifytags
      gotests
      gore
      hugo
      html-tidy
      stylelint
      js-beautify
      typescript-language-server
      vscode-langservers-extracted
      nixfmt
      pyright
      ruff
      isort
      # Avoid Python 3.14 test regressions in nixos-unstable.
      (import inputs.nixpkgs-2605 {
        system = pkgs.stdenv.hostPlatform.system;
      }).pipenv
      black
      uv
      upx
      R
      tokei
      shellcheck
      gdtoolkit_4
      shfmt
      bash-language-server
      libxml2
    ];
  };
}
