{ ... }: {
  flake.nixosModules.networkTailscale = { ... }: {
    services.tailscale = {
      enable = true;
    };
  };
}
