{
  plugins.nvim-tree = {
    enable = true;
    diagnostics.enable = true;
    syncRootWithCwd = true;
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
