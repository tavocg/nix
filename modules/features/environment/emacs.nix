{ ... }: {
  flake.nixosModules.emacs = { config, lib, pkgs, ... }:
    let
      x11Enabled = lib.attrByPath [ "local" "x11" "enable" ] false config;
      waylandEnabled = lib.attrByPath [ "local" "wayland" "enable" ] false config;
    in {
      options.local.environment.packages.emacs = lib.mkOption {
        type = lib.types.package;
        readOnly = true;
        description = "Resolved Emacs package for this host.";
      };

      config.local.environment.packages.emacs =
        if waylandEnabled then
          pkgs.emacs-pgtk
        else if x11Enabled then
          pkgs.emacs
        else
          pkgs.emacs;
    };
}
