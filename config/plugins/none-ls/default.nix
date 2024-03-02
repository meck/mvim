{pkgs, ...}: {
  # NOTE: custom servers does is not configurable thru nixvim atm
  # https://github.com/nix-community/nixvim/issues/768
  extraConfigLuaPost = builtins.readFile ./none-ls.lua;

  extraPlugins = with pkgs.vimPlugins; [
    none-ls-nvim
  ];

  extraPackages = with pkgs; [
    alejandra
    checkmake
    hadolint
    shfmt
    statix
    stylua
    vim-vint
  ];

  imports = [./oelint-adv.nix];
}
