{
  plugins.treesitter = {
    enable = true;
    indent = true;
    folding = true;
    incrementalSelection.enable = false;
    nixGrammars = true;
    ensureInstalled = "all";
    nixvimInjections = true;
    disabledLanguages = ["markdown" "markdown-inline"];
  };
}
