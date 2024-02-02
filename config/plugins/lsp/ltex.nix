{pkgs, ...}: {
  # TODO: The convoluted language switching
  # doesen't work with nixvim
  extraPackages = with pkgs; [ltex-ls];
  extraPlugins = with pkgs.vimPlugins; [ltex_extra-nvim];
  extraConfigLua = builtins.readFile ./ltex.lua;
}
