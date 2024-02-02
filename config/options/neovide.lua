if vim.g.neovide then
    local o = vim.opt
    local font_size = 10.5
    local step = 0.3
    local font = "Iosevka Term ExtraLight"
    o.guifont = font .. ":h" .. font_size
    local getfontsize = function()
        return tonumber(string.match(o.guifont:get()[1], ":h(.*)"))
    end

    function _G.neovide_inc_font()
        o.guifont = font .. ":h" .. (getfontsize() + step)
    end

    function _G.neovide_dec_font()
        o.guifont = font .. ":h" .. (getfontsize() - step)
    end

    function _G.neovide_res_font()
        o.guifont = font .. ":h" .. font_size
    end

    local function map(mode, l, r, desc)
        local op = { noremap = true, silent = true }
        op.desc = desc
        vim.keymap.set(mode, l, r, op)
    end

    map("n", "<C-=>", _G.neovide_inc_font, "Neovide: increse fontsize")
    map("n", "<C-->", _G.neovide_dec_font, "Neovide: decrease fontsize")
    map("n", "<C-0>", _G.neovide_res_font, "Neovide: reset fontsize")
end
