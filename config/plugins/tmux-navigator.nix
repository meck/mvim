{
  plugins = {
    tmux-navigator = {
      enable = true;
      settings.no_mappings = 1;
    };
  };

  extraConfigLua = ''
    local function map_tmux(lhs, rhs, desc)
        local opts = { desc = desc, noremap = true, silent = true }
        vim.keymap.set("t", lhs, [[<C-\><C-n>]] .. rhs, opts)
        vim.keymap.set("n", lhs, rhs, opts)
        vim.keymap.set("i", lhs, "<esc>" .. rhs, opts)
    end

    map_tmux("<C-h>", [[:TmuxNavigateLeft<CR>]], "Navigate Left")
    map_tmux("<C-j>", [[:TmuxNavigateDown<CR>]], "Navigate Down")
    map_tmux("<C-k>", [[:TmuxNavigateUp<CR>]], "Navigate Up")
    map_tmux("<C-l>", [[:TmuxNavigateRight<CR>]], "Navigate Right")
  '';
}
