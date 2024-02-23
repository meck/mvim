if vim.g.neovide then
    local g = vim.g
    local o = vim.opt
    local scale_step = 1 + 0.10
    g.neovide_padding_top = 10
    g.neovide_padding_bottom = 10
    g.neovide_padding_right = 10
    g.neovide_padding_left = 10
    g.neovide_scale_factor = 1.0
    g.neovide_fullscreen = false

    local change_scale_factor = function(delta)
        g.neovide_scale_factor = g.neovide_scale_factor * delta
    end

    local function map(mode, l, r, desc)
        local op = { noremap = true, silent = true }
        op.desc = desc
        vim.keymap.set(mode, l, r, op)
    end

    map("n", "<C-=>", function()
        change_scale_factor(scale_step)
    end, "Neovide: increase scale")
    map("n", "<C-->", function()
        change_scale_factor(1 / scale_step)
    end, "Neovide: decrease scale")
    map("n", "<C-0>", function()
        g.neovide_scale_factor = 1.0
    end, "Neovide: reset scale")
end
