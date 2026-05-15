{ ... }: {
  flake.nixosModules.gaming = { config, lib, ... }: {
    config = lib.mkMerge [
      {
        hardware.uinput.enable = true;

        programs.steam.enable = true;

        services.sunshine = {
          enable = true;
          openFirewall = true;
        };
      }
      (lib.mkIf config.local.user.enable {
        users.users.${config.local.user.name}.extraGroups = lib.mkAfter [ "uinput" ];
      })
    ];
  };
}
