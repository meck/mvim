{pkgs, ...}: {
  # NOTE: custom servers does is not configurable thru nixvim atm
  # https://github.com/nix-community/nixvim/issues/768
  extraConfigLuaPost = builtins.readFile ./none-ls.lua;

  extraPlugins = with pkgs.vimPlugins; [
    none-ls-nvim
  ];

  extraPackages = with pkgs;
    [
      alejandra
      black
      hadolint
      ruff
      shellcheck
      shfmt
      statix
      stylua
      vim-vint
    ]
    ++ lib.optionals stdenv.isLinux
    [
      # Not working on Darwin
      checkmake
    ];

  imports = [./oelint-adv.nix];
}
