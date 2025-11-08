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
