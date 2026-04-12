{ ... }: {
  flake.nixosModules.user = { lib, config, ... }:
    let
      cfg = config.local.user;
    in {
      options.local.user = {
        enable = lib.mkEnableOption "primary user configuration";

        name = lib.mkOption {
          type = lib.types.str;
          description = "Primary username for this host.";
        };

        description = lib.mkOption {
          type = lib.types.str;
          description = "Description for the primary user.";
        };

        extraGroups = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ "wheel" "video" "input" ];
          description = "Base groups for the primary user.";
        };
      };

      config = lib.mkIf cfg.enable {
        users.users.${cfg.name} = {
          isNormalUser = true;
          description = cfg.description;
          extraGroups = cfg.extraGroups;
        };

        nix.settings.trusted-users = lib.mkAfter [ cfg.name ];
      };
    };
}
