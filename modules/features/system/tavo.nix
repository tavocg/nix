{ ... }: {
  flake.nixosModules.tavo = { pkgs, ... }: {
    users.users.tavo = {
      isNormalUser = true;
      description = "Gustavo Calvo";
      extraGroups = [ "networkmanager" "wheel" "video" "input" ];
    };

    nix.settings.trusted-users = lib.mkAfter [ "tavo" ];
  };
}
