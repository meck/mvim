{ pkgs, ... }:
{
  colorscheme = "nordfox";
  colorschemes = {
    melange.enable = true;
    catppuccin.enable = true;
    gruvbox-material-nvim.enable = true;
    everforest = {
      enable = true;
      settings.background = "hard";
    };
    nightfox = {
      enable = true;
      flavor = "nordfox";
      settings = {
        groups = {
          all = rec {
            LspInlayHint = {
              fg = "palette.fg3";
              bg = "palette.bg1";
            };
            NormalFloat = {
              fg = "palette.fg1";
              bg = "palette.bg2";
            };
            FloatBorder = NormalFloat;
          };
        };
        options = {
          dim_inactive = false;
          styles = {
            comments = "italic";
            keywords = "bold";
          };
        };
      };
    };
  };

  extraPlugins = with pkgs.vimPlugins; [
    zenbones-nvim
    lush-nvim
  ];
}
