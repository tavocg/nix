{ inputs, ... }: {
  flake.nixosModules.tailscale = { pkgs, ... }: {
    services.tailscale = {
      enable = true;
      interfaceName = "userspace-networking";
    };
  };
}
