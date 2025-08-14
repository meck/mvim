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

            src =
              let
                oldVersionDate = prev.vimPlugins.CopilotChat-nvim.version;
                overlayVersionDate = "2025-08-10";
                oldVersionInt = lib.toInt (builtins.replaceStrings [ "-" ] [ "" ] oldVersionDate);
                overlayVersionInt = lib.toInt (builtins.replaceStrings [ "-" ] [ "" ] overlayVersionDate);
              in
              assert lib.assertMsg (overlayVersionInt > oldVersionInt) "Remove copilot chat version overlay";

              final.fetchFromGitHub {
                owner = "CopilotC-Nvim";
                repo = "CopilotChat.nvim";
                rev = "f5fd1a7ead5ccdd240fc3ef6e740fb49f74a1294";
                hash = "sha256-bTMGu85jlgYyRLh1ugRxzLCrEznjIunhVf3XJpDMfEw=";
              };

            nvimSkipModules = [ "CopilotChat.integrations.fzflua" ];
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
