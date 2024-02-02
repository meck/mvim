{
  pkgs,
  lib,
  ...
}: {
  plugins = {
    neogit = {
      enable = true;
      # disableBuiltinNotifications = true;
      autoRefresh = true;
      integrations.diffview = true;
    };

    gitsigns = {
      enable = true;
      onAttach.function = builtins.readFile ./git_mappings.lua;
    };

    # For mergetool
    fugitive.enable = true;
    lualine.extensions = ["fugitive"];
  };

  keymaps = [
    {
      mode = "n";
      key = "gk";
      action = "require('neogit').open";
      lua = true;
      options = {
        silent = true;
        desc = "neogit: open";
      };
    }
  ];
}
