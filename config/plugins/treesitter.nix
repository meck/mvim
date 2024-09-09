{
  plugins.treesitter = {
    enable = true;
    settings = {
      indent.enable = true;
      incrementalSelection.enable = false;
      highlight = {
        enable = true;
        disable = [
          "markdown"
          "markdown-inline"
        ];
      };
    };
  };
}
