{ ... }: {
  flake.nixosModules.ssh = { config, lib, ... }:
    let
      cfg = config.local.ssh;
    in {
      options.local.ssh = {
        enable = lib.mkEnableOption "OpenSSH access for the primary user";

        authorizedKeys = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFKPVj4UOvvNv5JxeJ0mfe+5gWNMnKIyW9wLykSPRlPM tavo@desktop"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHkCMsi9s7M0RROph5s1jmBEBo7JYIL53hPWxN3NK1nj tavo@laptop"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOP9ZXfKni75W/8bNWmzChPzPfwjLerFiyn22nVpAKYX tavo@phone"
          ];
          description = "SSH public keys allowed for the primary user.";
        };
      };

      config = lib.mkIf cfg.enable (lib.mkMerge [
        {
          services.openssh = {
            enable = true;
            openFirewall = true;
            settings = {
              PasswordAuthentication = false;
              KbdInteractiveAuthentication = false;
              PermitRootLogin = "no";
            };
          };
          programs.ssh.startAgent = true;
        }
        (lib.mkIf config.local.user.enable {
          users.users.${config.local.user.name}.openssh.authorizedKeys.keys = cfg.authorizedKeys;
        })
      ]);
    };
}
