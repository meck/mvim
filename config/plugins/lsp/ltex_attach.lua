-- Switch language for LTeX server

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

local function update_client_langauge(new_language)
    if client.config.settings.ltex == nil then
        client.config.settings.ltex = {}
    end
    client.config.settings.ltex = vim.tbl_deep_extend("force", client.config.settings.ltex, { language = new_language })
    client.notify("workspace/didChangeConfiguration", client.config.settings)
end

vim.api.nvim_buf_create_user_command(0, "LTeXSwitchLang", function(opts)
    if opts.args ~= "" then
        local new_lang = opts.args
        if not vim.tbl_contains(ltex_languages, new_lang) then
            vim.notify(string.format("Unsupported language: " .. new_lang), vim.log.levels.ERROR)
        else
            update_client_langauge(opts.args)
        end
    else
        vim.ui.select(ltex_languages, { prompt = "Select language:" }, function(choice)
            update_client_langauge(choice)
        end)
    end
end, { nargs = "?", desc = "ltex_extra.nvim: Switch sever language" })
