{
  plugins.toggleterm = {
    enable = true;
    settings = {
      size = ''
        function(term)
            if term.direction == "horizontal" then
                return 15
            elseif term.direction == "vertical" then
                return vim.o.columns * 0.4
            end
        end
      '';
      direction = "horizontal";
      open_mapping = "[[<c-\\>]]";
    };
  };

  plugins.lualine.settings.extensions = [ "toggleterm" ];
}
