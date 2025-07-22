{ lib, ... }:
{
  imports = [
    ./options
    ./plugins
    ./mappings
    ./theme
  ];

  config = {
    nixpkgs.overlays = [
      (final: prev: {
        # https://github.com/nix-community/nixvim/issues/3576
        vimPlugins = prev.vimPlugins // {
          CopilotChat-nvim = prev.vimPlugins.CopilotChat-nvim.overrideAttrs (_: {
            nvimSkipModules = [ "CopilotChat.integrations.fzflua" ];
          });
          nvim-notify = prev.vimPlugins.nvim-notify.overrideAttrs (_: {
            nvimSkipModules = [ "notify.integrations.fzf" ];
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
