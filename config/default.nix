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
