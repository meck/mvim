{ pkgs, ... }:
{
  colorscheme = "nord";
  colorschemes = {
    melange.enable = true;
    catppuccin.enable = true;
    gruvbox-material-nvim.enable = true;
    everforest = {
      enable = true;
      settings.background = "hard";
    };
  };

  extraConfigLuaPre = ''
    require("nord").setup({
      styles = {
        lualine_bold = true,
      },
      -- Colors mixed to background colors
      on_highlights = function(highlights, colors)
        highlights.DiffAdd = { bg = "#424b4d" }
        highlights.DiffDelete = { bg = "#433a46" }
        highlights.DiffChange = { bg = "#494a4b" }
        highlights.DiffText = { bg = "#5e5a52" }
      end,
    })
  '';

  extraPlugins = with pkgs.vimPlugins; [
    gbprod-nord
    zenbones-nvim
  ];
}
