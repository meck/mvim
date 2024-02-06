{lib, ...}: {
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

  config = {
    extraFiles = {
      "keymap/swe-us_utf-8.vim" = builtins.readFile ./keymap/swe-us_utf-8.vim;
    };
  };
}
