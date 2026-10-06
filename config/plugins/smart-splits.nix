{
  # Move between Neovim splits and tmux or zellij panes with Ctrl+hjkl.
  # smart-splits finds the multiplexer from $TMUX or $ZELLIJ.
  plugins.smart-splits.enable = true;

  extraConfigLua = ''
    local function map_nav(lhs, rhs, desc)
        local opts = { desc = desc, noremap = true, silent = true }
        vim.keymap.set("t", lhs, [[<C-\><C-n>]] .. rhs, opts)
        vim.keymap.set("n", lhs, rhs, opts)
        vim.keymap.set("i", lhs, "<esc>" .. rhs, opts)
    end

    map_nav("<C-h>", [[<cmd>lua require("smart-splits").move_cursor_left()<CR>]], "Navigate Left")
    map_nav("<C-j>", [[<cmd>lua require("smart-splits").move_cursor_down()<CR>]], "Navigate Down")
    map_nav("<C-k>", [[<cmd>lua require("smart-splits").move_cursor_up()<CR>]], "Navigate Up")
    map_nav("<C-l>", [[<cmd>lua require("smart-splits").move_cursor_right()<CR>]], "Navigate Right")
  '';
}
