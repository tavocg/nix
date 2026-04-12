{ inputs, ... }: {
  flake.homeModules.gnupg = { pkgs, config, ... }: let
    anypinentry = inputs.anypinentry.packages.${pkgs.stdenv.hostPlatform.system}.default;
  in {
    programs.gpg = {
      enable = true;
      homedir = "${config.xdg.dataHome}/gnupg";
    };

    services.gpg-agent = {
      enable = true;
      pinentry.package = anypinentry;
    };
  };
}
