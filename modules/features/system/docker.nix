{ ... }: {
  flake.nixosModules.docker = { lib, config, ... }: {
    virtualisation.docker.enable = true;

    config = lib.mkIf config.local.user.enable {
      users.users.${config.local.user.name}.extraGroups = lib.mkAfter [ "docker" ];
    };
  };
}
