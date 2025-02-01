{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (config.mvim) small;
in
lib.mkMerge [
  {
    plugins.none-ls = {
      enable = true;
      sources = {
        diagnostics = {
          checkmake.enable = true;
          hadolint.enable = true;
          vint.enable = !small;
          protolint.enable = !small;
        };
        formatting = {
          # Formatting fails as the linter complains
          # about the temp file name and renames it.
          # https://github.com/nvimtools/none-ls.nvim/pull/34
          # protolint.enable = !small;
          shfmt = {
            enable = true;
            settings =
              # lua
              ''{ extra_args = { "-i", "4", "-ci", "-bn", "-sr"  } }'';
          };

          stylua = {
            enable = true;
            settings =
              # lua
              ''{ extra_args = { "--indent-type", "Spaces", "--indent-width", "4" } }'';
          };
        };
      };
    };
  }

  # NOTE: custom servers does is not configurable thru nixvim atm
  (lib.mkIf (!config.mvim.small) {
    extraConfigLuaPost = builtins.readFile ./oelint-adv.lua;
    extraPackages = [ pkgs.oelint-adv ];
  })
]
