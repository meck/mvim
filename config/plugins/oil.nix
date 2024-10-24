{
  plugins.oil = {
    enable = true;
    settings = {
      columns = [
        "icons"
        "permissions"
        "size"
      ];
      keymaps = {
        "<C-c>" = false;
        "<C-l>" = false;
        "<C-r>" = "actions.refresh";
        "q" = "actions.close";
        "y." = "actions.copy_entry_path";
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "-";
      action = "<cmd>:Oil<cr>";
      options = {
        silent = true;
        desc = "Oil: Open parent directory";
      };
    }
  ];

  plugins.lualine.settings.extensions = [ "oil" ];

}
