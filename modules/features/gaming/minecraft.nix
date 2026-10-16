{ ... }: {
  flake.nixosModules.gamingMinecraft = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      jdk21Xdg
      prismlauncher
    ];
  };
}
