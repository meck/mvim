_: {
  colorscheme = "nordfox";
  colorschemes = {
    melange.enable = true;
    nightfox = {
      enable = true;
      flavor = "nordfox";
      settings = {
        groups = {
          all = {
            LspInlayHint = {
              fg = "palette.fg3";
              bg = "palette.bg1";
              style = "bold";
            };
          };
        };
        options = {
          dim_inactive = false;
          styles = {
            comments = "italic";
            keywords = "bold";
            types = "bold";
          };
        };
      };
    };
  };
}
