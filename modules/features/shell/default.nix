{ self, ... }: {
  flake.nixosModules.shell = { pkgs, ... }: {
    imports = [
    ];

    environment.systemPackages = with pkgs; [
      git
      lazygit
      yazi
      eza
    ];
  };
}
