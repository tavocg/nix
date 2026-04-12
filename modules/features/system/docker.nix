{ ... }: {
  flake.nixosModules.docker = { lib, config, ... }: {
    config = lib.mkMerge [
      {
        virtualisation.docker.enable = true;
      }
      (lib.mkIf config.local.user.enable {
        users.users.${config.local.user.name}.extraGroups = lib.mkAfter [ "docker" ];
      })
    ];
  };
}
