{ inputs, ... }: {
  flake.nixosModules.sway = { pkgs, ... }: {
    programs.sway = let
      shtatus = pkgs.stdenvNoCC.mkDerivation {
        pname = "shtatus";
        version = "unstable";
        src = inputs.shtatus;
        dontUnpack = true;

        installPhase = ''
          install -Dm755 "$src/shtatus" "$out/bin/shtatus"
        '';
      };
    in {
      enable = true;
      wrapperFeatures.gtk = true;

      extraPackages = with pkgs; [
        foot
        wl-clipboard
        bemenu
        slurp
        grim
        shtatus
      ];
    };
  };
}
