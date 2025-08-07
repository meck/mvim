{
  plugins.nvim-tree = {
    enable = true;
    settings = {
      diagnostics.enable = true;
      sync_root_with_cwd = true;
    };
  };

  plugins.lualine.settings.extensions = [ "nvim-tree" ];

  keymaps = [
    {
      mode = "n";
      key = "<leader><tab>";
      action = "<cmd>:NvimTreeToggle<cr>";
      options = {
        silent = true;
        desc = "Nvim-tree: Toggle";
      };
    }
    {
      mode = "n";
      key = "<leader>-";
      action = "<cmd>:NvimTreeFindFile<cr>";
      options = {
        silent = true;
        desc = "Nvim-tree: Current file";
      };
    }
  ];
}
