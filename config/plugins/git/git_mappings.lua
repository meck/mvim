function(bufnr)
    local gs = package.loaded.gitsigns
    local function map(mode, l, r, desc, opts)
        local default_opts = { noremap = true, silent = true }
        local op = vim.tbl_extend("force", default_opts, opts or {})
        op.desc = desc
        vim.keymap.set(mode, l, r, op)
    end
    local function map_gs(mode, l, r, desc, expr)
        map(mode, l, r, desc, { buffer = bufnr, expr = expr or false })
    end

    -- Navigation
    map_gs("n", "]c", function()
        if vim.wo.diff then
            return "]c"
        end
        vim.schedule(function()
            gs.next_hunk()
        end)
        return "<Ignore>"
    end, "Git: next git hunk", true)

    map_gs("n", "[c", function()
        if vim.wo.diff then
            return "[c"
        end
        vim.schedule(function()
            gs.prev_hunk()
        end)
        return "<Ignore>"
    end, "Git: prev git hunk", true)

    -- Actions
    map_gs({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", "Git: stage hunk")
    map_gs({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", "Git: reset hunk")
    map_gs("n", "<leader>hS", gs.stage_buffer, "Git: stage buffer")
    map_gs("n", "<leader>hu", gs.undo_stage_hunk, "Git: undo stage hunk")
    map_gs("n", "<leader>hR", gs.reset_buffer, "Git: reset buffer")
    map_gs("n", "<leader>hp", gs.preview_hunk, "Git: preview hunk")
    map_gs("n", "<leader>hb", function()
        gs.blame_line({ full = true })
    end, "Git: blame line")
    map_gs("n", "<leader>tb", gs.toggle_current_line_blame, "Git: toggle blame line")
    map_gs("n", "<leader>hd", gs.diffthis, "Git: diffthis")
    map_gs("n", "<leader>hD", function()
        gs.diffthis("~")
    end, "Git: diffthis ~")
    map_gs("n", "<leader>td", gs.toggle_deleted, "Git: toggle deleted")

    -- Text object
    map_gs({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Git: select hunk")
end
