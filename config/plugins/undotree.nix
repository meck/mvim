{
  # TODO: merged in mainline nvim
  plugins.undotree.enable = true;

  keymaps = [
    {
      mode = "n";
      key = "<leader>u";
      action = "<cmd>:UndotreeToggle<cr>";
      options.silent = true;
    }
  ];

}
