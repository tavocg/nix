{ ... }: {
  flake.nixosModules.nixos = { pkgs, ... }: {
    nixpkgs.config.allowUnfree = true;

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    nix.settings.use-xdg-base-directories = true;

    # research this later?
    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = [ pkgs.udev ];

    # Maintenance / storage cleanup shared by every host.
    services.journald.settings.Journal = {
      SystemMaxUse = "500M";
      MaxRetentionSec = "7day";
    };

    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

    boot.tmp.cleanOnBoot = true;
  };
}
