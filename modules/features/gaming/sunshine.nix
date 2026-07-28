{ ... }: {
  flake.nixosModules.gamingSunshine = { config, lib, pkgs, ... }:
    let
      cudaEnabled = lib.attrByPath [ "local" "nvidia" "cuda" "enable" ] false config;
      sunshinePackage =
        if cudaEnabled then
          pkgs.sunshine.override {
            cudaSupport = true;
            cudaPackages = pkgs.cudaPackages;
          }
        else
          pkgs.sunshine;
    in
    {
      config = lib.mkMerge [
        {
          hardware.uinput.enable = true;

          services.sunshine = {
            enable = true;
            openFirewall = true;
            package = sunshinePackage;
          };
        }
        (lib.mkIf config.local.user.enable {
          users.users.${config.local.user.name}.extraGroups = lib.mkAfter [ "uinput" ];
        })
      ];
    };
}
