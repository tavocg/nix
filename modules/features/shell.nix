{ ... }: {
  flake.nixosModules.shell = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      firefox
      neovim
      git
      lazygit
      gcc
      yazi
    ];
  };
}
