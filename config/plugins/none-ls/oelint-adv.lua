do
    local null_ls = require("null-ls")
    local helpers = require("null-ls.helpers")
    local pattern = "([^:]+):(%d+):(%a+):([^:]+):(.+)%s*%[branch:([^%]]+)%]"

    local oelint_adv = {
        name = "oelint-adv",
        method = null_ls.methods.DIAGNOSTICS,
        filetypes = { "bitbake" },
        generator = null_ls.generator({
            command = "oelint-adv",
            args = {
                "--exit-zero",
                "--quiet",
                "--messageformat='{path}:{line}:{severity}:{id}:{msg}'",
                "$FILENAME",
            },
            from_stderr = true,
            format = "line",
            -- TODO: not working any good
            -- multiple_files = true,
            on_output = helpers.diagnostics.from_pattern(pattern, {
                "filename",
                "row",
                "severity",
                "code",
                "message",
                "_branch_suffix",
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
