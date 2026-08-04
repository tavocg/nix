{ ... }: {
  flake.nixosModules.systemAppImage = { ... }: {
    programs.appimage = {
      enable = true;
      binfmt = true;
    };
  };
}
