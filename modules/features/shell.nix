let
  externalRepo = pkgs.fetchFromGitHub {
    owner = "tavocg";
    repo = "dotfiles";
    rev = "a2255e0";
    sha256 = "0000000000000000000000000000000000000000000000000000"; # placeholder
  };

  scriptsDir = "${externalRepo}/scripts";
in
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

    environment.sessionVariables.PATH = "${scriptsDir}:${builtins.getEnv "PATH"}";
  };
}
