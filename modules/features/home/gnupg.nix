{ ... }: {
  flake.homeModules.gnupg = { pkgs, config, ... }: {
    home.sessionVariables = {
      GNUPGHOME = "${config.xdg.dataHome}/gnupg";
    };

    programs.gpg = {
      enable = true;
      homedir = "${config.xdg.dataHome}/gnupg";
    };

    services.gpg-agent = {
      enable = true;
      pinentry.package = pkgs.pinentry-bemenu;
    };
  };
}
