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
          image-nvim = prev.vimPlugins.image-nvim.overrideAttrs (_: {
            src =
              assert lib.assertMsg (
                prev.vimPlugins.image-nvim.version == "1.3.0-1-unstable-1.3.0-1"
              ) "Remove image-nvim overlay";
              final.fetchFromGitHub {
                owner = "3rd";
                repo = "image.nvim";
                rev = "446a8a5cc7a3eae3185ee0c697732c32a5547a0b";
                sha256 = "sha256-EaDeY8aP41xHTw5epqYjaBqPYs6Z2DABzSaVOnG6D6I=";
              };
          });

          nvim-dap-cortex-debug = prev.vimPlugins.nvim-dap-cortex-debug.overrideAttrs (_: {
            src =
              assert lib.assertMsg (
                prev.vimPlugins.nvim-dap-cortex-debug.version == "2025-02-13"
              ) "Check nvim-dap-cortex-debug";
              final.fetchFromGitHub {
                owner = "meck";
                repo = "nvim-dap-cortex-debug";
                rev = "de37a98fc5643e8b3daade24e1b1409442640882";
                sha256 = "sha256-dGWm6eVo2d9TAnV17p+xtqE7I8BZr/Znv104GdEbuI4=";
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
