{pkgs, ... }: {
  imports = [
    ./options
    ./plugins
    ./mappings
    ./theme
  ];

  extraFiles = {
    "keymap/swe-us_utf-8.vim" = builtins.readFile ./keymap/swe-us_utf-8.vim;
  };
}
