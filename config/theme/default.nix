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
    })
  '';

  extraPlugins = with pkgs.vimPlugins; [
    gbprod-nord
    zenbones-nvim
  ];
}
