{
  pkgs,
  lib,
  ...
}: {
  colorscheme = lib.mkForce "nordfox";
  colorschemes = {
    melange.enable = true;
  };
  extraPlugins = with pkgs.vimPlugins; [nightfox-nvim];

  extraConfigLuaPre = ''
    require("nightfox").setup({
        options = {
            dim_inactive = false,
            styles = {
                comments = "italic",
                keywords = "bold",
                types = "bold",
            },
        },
    })
  '';
}
