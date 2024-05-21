{
  plugins.trouble.enable = true;

  keymaps = [
    {
      mode = "n";
      key = "<leader>xx";
      action = "<cmd>TroubleToggle<cr>";
      options = {
        silent = true;
        desc = "Trouble: toggle";
      };
    }
    {
      mode = "n";
      key = "<leader>xw";
      action = "<cmd>TroubleToggle workspace_diagnostics<cr>";
      options = {
        silent = true;
        desc = "Trouble: workspace toggle";
      };
    }
    {
      mode = "n";
      key = "<leader>xd";
      action = "<cmd>TroubleToggle document_diagnostics<cr>";
      options = {
        silent = true;
        desc = "Trouble: document toggle";
      };
    }
    {
      mode = "n";
      key = "<leader>xl";
      action = "<cmd>TroubleToggle loclist<cr>";
      options = {
        silent = true;
        desc = "Trouble: loclist";
      };
    }
    {
      mode = "n";
      key = "<leader>xq";
      action = "<cmd>TroubleToggle quickfix<cr>";
      options = {
        silent = true;
        desc = "Trouble: quickfix";
      };
    }
  ];

  plugins.lualine.extensions = [ "trouble" ];
}
