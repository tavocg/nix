{ ... }: {
  flake.nixosModules.ssh = { lib, config, ... }:
    let
      cfg = config.local.ssh;
    in {
      options.local.ssh = {
        enable = lib.mkEnableOption "OpenSSH server configuration";

        localKeys = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          description = "SSH public keys allowed for the local user on this host.";
        };
      };

      config = lib.mkIf cfg.enable {
        assertions = [
          {
            assertion = config.local.user.enable;
            message = "local.ssh.enable requires local.user.enable so SSH keys can be assigned to the local user.";
          }
        ];

        services.openssh = {
          enable = true;
          settings = {
            PasswordAuthentication = false;
            KbdInteractiveAuthentication = false;
          };
        };

        users.users.${config.local.user.name}.openssh.authorizedKeys.keys = cfg.localKeys;
      };
    };
}
