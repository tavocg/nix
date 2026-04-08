{ ... }: {
  flake.nixosModules.cr = { pkgs, ... }: {
    i18n.supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "es_CR.UTF-8/UTF-8"
    ];

    i18n.defaultLocale = "en_US.UTF-8";

    time.timeZone = "America/Costa_Rica";
  };
}
