{ self, ... }: {
  flake.nixosModules.shell = { pkgs, ... }: {
    imports = [
    ];

    environment.shellInit = ''
      for f in ~/.config/shell/profile.d/*.sh; do
        if [ -r "$f" ]; then
          . "$f"
        fi
      done
    '';

    environment.systemPackages = with pkgs; [
      git
      lazygit
      yazi
      eza
    ];
  };
}
