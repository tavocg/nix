{ ... }: {
  flake.nixosModules.virt = { config, lib, ... }: {
    config = lib.mkMerge [
      {
        virtualisation.libvirtd.enable = true;
        programs.virt-manager.enable = true;
      }
      (lib.mkIf config.local.user.enable {
        users.users.${config.local.user.name}.extraGroups = lib.mkAfter [ "libvirtd" ];
      })
    ];
  };
}
