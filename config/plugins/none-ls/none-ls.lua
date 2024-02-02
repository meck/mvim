local null_ls = require("null-ls")
local helpers = require("null-ls.helpers")

null_ls.setup({
    sources = {
        null_ls.builtins.code_actions.shellcheck,
        null_ls.builtins.code_actions.statix,
        null_ls.builtins.diagnostics.checkmake,
        null_ls.builtins.diagnostics.hadolint,
        null_ls.builtins.diagnostics.ruff,
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.diagnostics.statix,
        null_ls.builtins.diagnostics.vint,
        null_ls.builtins.formatting.alejandra,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.shfmt.with({ extra_args = { "-i", "4", "-ci", "-bn", "-sr" } }),
        null_ls.builtins.formatting.stylua.with({ extra_args = { "--indent-type", "Spaces", "--indent-width", "4" } }),
    },
    -- debug = true,
})

local oelint_adv = {
    method = null_ls.methods.DIAGNOSTICS,
    filetypes = { "bitbake" },
    generator = null_ls.generator({
        command = "oelint-adv",
        args = {
            "--exit-zero",
            "--quiet",
            "$FILENAME",
        },
        to_temp_file = true,
        from_stderr = true,
        format = "line",
        diagnostics_format = "[#{c}] #{m} (#{s})",
        on_output = helpers.diagnostics.from_pattern([[^.*:(%d+):(.*):(.*):(.*)$]], {
            "row",
            "severity",
            "code",
            "message",
        }, {
            severities = {
                error = helpers.diagnostics.severities["error"],
                warning = helpers.diagnostics.severities["warning"],
                info = helpers.diagnostics.severities["information"],
            },
        }),
    }),
}

null_ls.register({ oelint_adv })
