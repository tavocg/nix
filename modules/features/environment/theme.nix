{ ... }: {
  flake.nixosModules.environmentTheme = {
    config,
    lib,
    pkgs,
    ...
  }:

  let
    x11Enabled = config.local.x11.enable;
    waylandEnabled = config.local.wayland.enable;
    windowingEnabled = x11Enabled || waylandEnabled;
  in {
    config = lib.mkIf windowingEnabled {
      environment.systemPackages = [
        pkgs.gnome-themes-extra
      ] ++ lib.optionals x11Enabled [
        pkgs.xsettingsd
      ];
    };
  };
}
