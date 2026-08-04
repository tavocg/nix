{ ... }: {
  flake.nixosModules.systemDocker = { lib, config, ... }: {
    config = lib.mkMerge [
      {
        virtualisation.docker.enable = true;
        virtualisation.docker.enableOnBoot = lib.mkDefault false;
      }
      (lib.mkIf config.local.user.enable {
        users.users.${config.local.user.name}.extraGroups = lib.mkAfter [ "docker" ];
      })
    ];
  };
}
