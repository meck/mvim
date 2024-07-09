{
  plugins.treesitter = {
    enable = true;
    settings = {
      indent.enable = true;
      incrementalSelection.enable = false;
      highlight.disable = [
        "markdown"
        "markdown-inline"
      ];
    };
  };
}
