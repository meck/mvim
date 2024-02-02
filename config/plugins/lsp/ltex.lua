-- Swithing function according to: https://github.com/barreiroleo/ltex_extra.nvim/issues/12
local ltex_settings = {
    ltex = {
        enabled = { "markdown", "latex", "mail", "gitcommit" },
        language = "en-US",
        additionalRules = {
            motherTongue = "sv",
        },
    },
}

local ltex_languages = {
    "auto",
    "ar",
    "ast-ES",
    "be-BY",
    "br-FR",
    "ca-ES",
    "ca-ES-valencia",
    "da-DK",
    "de",
    "de-AT",
    "de-CH",
    "de-DE",
    "de-DE-x-simple-language",
    "el-GR",
    "en",
    "en-AU",
    "en-CA",
    "en-GB",
    "en-NZ",
    "en-US",
    "en-ZA",
    "eo",
    "es",
    "es-AR",
    "fa",
    "fr",
    "ga-IE",
    "gl-ES",
    "it",
    "ja-JP",
    "km-KH",
    "nl",
    "nl-BE",
    "pl-PL",
    "pt",
    "pt-AO",
    "pt-BR",
    "pt-MZ",
    "pt-PT",
    "ro-RO",
    "ru-RU",
    "sk-SK",
    "sl-SI",
    "sv",
    "ta-IN",
    "tl-PH",
    "uk-UA",
    "zh-CN",
}

require("lspconfig").ltex.setup({
    settings = ltex_settings,
    filetypes = { "markdown", "tex", "mail", "gitcommit" },
    on_attach = function(client, bufnr)
        require("ltex_extra").setup({
            load_langs = { "en-US", "sv" },
            init_check = true,
            path = vim.fn.expand("~") .. "/.local/share/ltex",
        })
        vim.api.nvim_buf_create_user_command(0, "LTexSwitchLang", function(opts)
            if opts.args ~= "" then
                ltex_settings.ltex.language = opts.args
                client.notify("workspace/didChangeConfiguration", { setings = ltex_settings })
            else
                vim.ui.select(ltex_languages, {
                    prompt = "Select language:",
                }, function(choice)
                    ltex_settings.ltex.language = choice
                    client.notify("workspace/didChangeConfiguration", { setings = ltex_settings })
                end)
            end
        end, { nargs = "?", desc = "ltex_extra.nvim: Switch sever language" })
    end,
})
