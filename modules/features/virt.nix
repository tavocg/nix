{ ... }: {
    flake.nixosModules.virt = { config, lib, ... }: {
        config = lib.mkMerge [
            {
                virtualisation.libvirtd.enable = true;
                virtualisation.libvirtd.qemu.swtpm.enable = true;
                # virt-manager and guest restoration can both start libvirtd via its socket.
                systemd.services.libvirtd.wantedBy = lib.mkForce [ ];
                programs.virt-manager.enable = true;
            }
            (lib.mkIf config.local.user.enable {
                users.users.${config.local.user.name}.extraGroups = lib.mkAfter [ "libvirtd" ];
            })
        ];
    };
}
