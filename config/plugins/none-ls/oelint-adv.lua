do
    local null_ls = require("null-ls")
    local helpers = require("null-ls.helpers")

    -- Get all open 'bitbake' buffer and always check all of them
    local gen_args = function(params)
        local def_args = {
            "--exit-zero",
            "--quiet",
            "--messageformat={path}:{line}:{severity}:{id}:{msg}",
        }

        local buffers = vim.api.nvim_list_bufs()
        local files = {}

        for _, bufnr in ipairs(buffers) do
            if vim.api.nvim_buf_is_loaded(bufnr) then
                local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
                local bufname = vim.api.nvim_buf_get_name(bufnr)
                -- Check file is in current root
                if ft == "bitbake" and vim.startswith(bufname, params.root) then
                    table.insert(files, bufname)
                end
            end
        end

        local args = vim.deepcopy(def_args)
        vim.list_extend(args, files)
        return args
    end

    local pattern = "([^:]+):(%d+):(%a+):([^:]+):(.+)%s*%[branch:([^%]]+)%]"

    local oelint_adv = {
        name = "oelint-adv",
        method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
        filetypes = { "bitbake" },
        generator = null_ls.generator({
            command = "oelint-adv",
            args = gen_args,
            from_stderr = true,
            format = "line",
            multiple_files = true,
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
