{ lib, ... }:
{
  imports = [
    ./filetype
    ./mappings
    ./options
    ./plugins
    ./theme
  ];

  config = {
    nixpkgs.overlays = [
      (final: prev: {
        vimPlugins = prev.vimPlugins // {
          codediff-nvim = prev.vimPlugins.codediff-nvim.overrideAttrs (_: {
            version = "2.45.0";
            src =
              assert lib.assertMsg (prev.vimPlugins.codediff-nvim.version == "2.43.15") "Check codediff-nvim";
              final.fetchFromGitHub {
                owner = "esmuellert";
                repo = "codediff.nvim";
                tag = "v2.45.0";
                hash = "sha256-Up4vH5yk13don0HrmHHpqrPIKtc1MTtDbZ6QcMHQYAU=";
              };
          });

          nvim-dap-cortex-debug = prev.vimPlugins.nvim-dap-cortex-debug.overrideAttrs (_: {
            src =
              assert lib.assertMsg (
                prev.vimPlugins.nvim-dap-cortex-debug.version == "0-unstable-2025-02-13"
              ) "Check nvim-dap-cortex-debug";
              final.fetchFromGitHub {
                owner = "meck";
                repo = "nvim-dap-cortex-debug";
                rev = "f3b03a03aac465b925b255a5084973de27a8aeaa";
                sha256 = "sha256-fNWTDpHR6tPa+4PAc2xGb6tCnFf7H8XnN+hDgRlwDbg=";
              };
          });

        };
      })
    ];
  };

  options = {
    mvim.small = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Build a smaller version not bundling large LSP servers";
    };
  };
}
