do
    local null_ls = require("null-ls")
    local helpers = require("null-ls.helpers")

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
end
