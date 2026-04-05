{ self, inputs, ... }: {
  flake.nixosModules.shell = { lib, pkgs, ... }:
    let
      extraPathEntries = [
        "$HOME/.local/bin"
      ];
      aliasMap = {
        ll = "ls -lah";
      };
      pathExport =
        lib.concatStringsSep ":" extraPathEntries;
    in {
      users.defaultUserShell = pkgs.bashInteractive;

      environment.localBinInPath = true;

      programs.bash = {
        enable = true;
        shellAliases = aliasMap;
        interactiveShellInit = ''
          export PATH="${pathExport}:$PATH"
        '';
      };
    };
}
