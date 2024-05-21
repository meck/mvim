{ lib, ... }:
{
  imports = [
    ./options
    ./plugins
    ./mappings
    ./theme
  ];

  options = {
    mvim.small = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Build a smaller version not bundling large LSP servers";
    };
  };
}
