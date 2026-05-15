{ ... }: {
  flake.nixosModules.gamingMinecraft = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      jdk
      prismlauncher
    ];
  };
}
