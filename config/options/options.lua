local o = vim.opt
local g = vim.g
local fn = vim.fn
local api = vim.api

-- Delete all but the current buffer
vim.cmd([[ command! Bonly silent! execute "%bd|e#|bd#" ]])

local function change_ltex_lang(new_lang)
    if api.nvim_buf_get_commands(0, {}).LTexSwitchLang then
        vim.cmd.LTexSwitchLang(new_lang)
    end
end

function _G.swe_mode_toggle()
    if vim.opt.keymap:get() ~= "" then
        o.keymap = ""
        o.spelllang = "en_us"
        change_ltex_lang("en-US")
    else
        o.keymap = "swe-us"
        o.spelllang = "sv"
        change_ltex_lang("sv")
    end
end

-- Diagnostics
vim.diagnostic.config({
    virtual_text = false,
    update_in_insert = true,
})

-- Signs and their highlights
fn.sign_define("DiagnosticSignError", {
    text = "",
    texthl = "DiagnosticError",
})
fn.sign_define("DiagnosticSignWarn", {
    text = "",
    texthl = "DiagnosticWarn",
})
fn.sign_define("DiagnosticSignInfo", {
    text = "",
    texthl = "DiagnosticInfo",
})
fn.sign_define("DiagnosticSignHint", {
    text = "",
    texthl = "DiagnosticHint",
})