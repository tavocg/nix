{ ... }: {
  flake.nixosModules.packagesDev = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      # android
      androidenv.androidPkgs.platform-tools
      scrcpy

      # c and c++
      binutils
      clang-tools
      cmake
      cppcheck
      cpplint
      gcc
      libxml2
      pkg-config

      # go
      go
      gomodifytags
      golangci-lint
      gopls
      gore
      gotests

      # web
      html-tidy
      js-beautify
      stylelint
      typescript-language-server
      vscode-langservers-extracted

      # nix
      nixfmt

      # python
      black
      isort
      pipenv
      pyright
      ruff
      uv

      # r
      R

      # shell
      bash-language-server
      shellcheck
      shfmt

      # tooling
      git
      lazygit
      lazydocker
      autoconf
      automake
      bison
      fakeroot
      gdtoolkit_4
      gnumake
      hugo
      markdownlint-cli
      m4
      tesseract
      tokei
      upx
    ];
  };
}
