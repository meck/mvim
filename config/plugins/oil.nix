{
  plugins.oil = {
    enable = true;
    settings = {
      skip_confirm_for_simple_edits = true;
      watch_for_changes = true;

      columns = [
        "permissions"
        "size"
        "icon"
      ];

      keymaps = {
        "<C-c>" = false;
        "q" = "actions.close";
        "<C-l>" = false;
        "<C-r>" = "actions.refresh";
        "<C-s>" = false; # open vert
        "<C-h>" = false; # open hor
        "<C-t>" = false; # open tab
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
