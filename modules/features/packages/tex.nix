{ ... }: {
  flake.nixosModules.packagesTex = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      # Full TeX Live includes the packages used in Documents: TikZ/PGF,
      # PGFPlots, CircuitikZ, pgf-pie, siunitx, AMS packages, Babel,
      # fontspec, tcolorbox, Beamer, standalone, and BibLaTeX.
      # It also provides pdfLaTeX, XeLaTeX, LuaLaTeX, latexmk, Biber,
      # BibTeX, ChkTeX, latexindent, and SyncTeX.
      texliveFull

      # LaTeX language server for editor completion and diagnostics.
      texlab
    ];
  };
}
