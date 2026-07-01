{ ... }: {
  flake.nixosModules.emacs = { config, lib, pkgs, ... }:
    let
      x11Enabled = lib.attrByPath [ "local" "x11" "enable" ] false config;
      waylandEnabled = lib.attrByPath [ "local" "wayland" "enable" ] false config;
      emacsPackage =
        if waylandEnabled then
          pkgs.emacs-pgtk
        else if x11Enabled then
          pkgs.emacs
        else
          pkgs.emacs;
    in {
      options.local.environment.packages.emacs = lib.mkOption {
        type = lib.types.package;
        readOnly = true;
        description = "Resolved Emacs package for this host.";
      };

      config = {
        local.environment.packages.emacs =
          (pkgs.emacsPackagesFor emacsPackage).emacsWithPackages (epkgs: [
            epkgs.mu4e
          ]);

        environment.systemPackages = with pkgs; [
          libtool
          libvterm
        ];
      };
    };
}
