{ ... }: {
  flake.nixosModules.tavo = { pkgs, lib, ... }: {
    users.users.tavo = {
      isNormalUser = true;
      description = "Gustavo Calvo";
      extraGroups = [ "wheel" "video" "input" ];
    };

    nix.settings.trusted-users = lib.mkAfter [ "tavo" ];
  };
}
