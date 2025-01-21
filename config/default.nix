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
        oelint-adv = prev.oelint-adv.overridePythonAttrs (oldAttrs: {
          # Fails on aarch64-darwin
          doCheck = false;
        });
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
