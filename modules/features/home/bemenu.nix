{ ... }: {
  flake.homeModules.bemenu = {
    home.sessionVariables = {
      BEMENU_OPTS =
        "--no-exec -i -c -l 10 -W 0.4 -B 2 -H 30 --cw 1 "
        + "--tb #7fbbb3 --tf #1e2326 "
        + "--fb #1e2326 --ff #374145 "
        + "--cb #1e2326 --cf #ebdbb2 "
        + "--nb #1e2326 --nf #374145 "
        + "--hb #7fbbb3 --hf #1e2326 "
        + "--ab #1e2326 --af #374145 "
        + "--bdr #7fbbb3 "
        + "--fn \"JetbrainsMono Medium 12\"";
    };
  };
}
