{
  pkgs,
  lib,
  config,
  ...
}:
lib.mkMerge [
  {
    plugins.none-ls = {
      enable = true;
      sources = {
        diagnostics = {
          checkmake.enable = true;
          hadolint.enable = true;
          vint.enable = !config.mvim.small;
        };
        formatting = {
          typstfmt.enable = true;
          shfmt = {
            enable = true;
            withArgs =
              # lua
              ''{ extra_args = { "-i", "4", "-ci", "-bn", "-sr"  } }'';
          };

          stylua = {
            enable = true;
            withArgs =
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
