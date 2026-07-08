{ inputs, ... }: {
  flake.nixosModules.emacs = { config, lib, pkgs, ... }:
    let
      pkgs-2605 = import inputs.nixpkgs-2605 {
        system = pkgs.stdenv.hostPlatform.system;
      };
      x11Enabled = lib.attrByPath [ "local" "x11" "enable" ] false config;
      waylandEnabled = lib.attrByPath [ "local" "wayland" "enable" ] false config;
      emacsPackage =
        if waylandEnabled then
          pkgs-2605.emacs-pgtk
        else if x11Enabled then
          pkgs-2605.emacs
        else
          pkgs-2605.emacs;
    in {
      options.local.environment.packages.emacs = lib.mkOption {
        type = lib.types.package;
        readOnly = true;
        description = "Resolved Emacs package for this host.";
      };

      config = {
        local.environment.packages.emacs =
          (pkgs-2605.emacsPackagesFor emacsPackage).emacsWithPackages (epkgs: [
            epkgs.mu4e
          ]);

        environment.systemPackages = with pkgs; [
          libtool
          libvterm
        ];
      };
    };
}
