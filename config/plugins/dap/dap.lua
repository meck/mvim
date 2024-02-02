local dap = require("dap")
dap.configurations.c = {
    {
        name = "Launch executable in lldb (codelldb)",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
    },
    {
        name = "Launch executable in lldb (lldb-vscode)",
        type = "lldb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
    },
    {
        name = "Launch executable in gdb (cppdbg)",
        type = "cppdbg",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopAtEntry = false,
        setupCommands = {
            {
                text = "source ${workspaceFolder}/.gdbinit",
                ignoreFailures = "true",
            },
            {
                text = "-enable-pretty-printing",
                description = "enable pretty printing",
                ignoreFailures = false,
            },
        },
    },
    {
        name = "Attach process",
        type = "cppdbg",
        request = "attach",
        processId = require("dap.utils").pick_process,
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        setupCommands = {
            {
                text = "source ${workspaceFolder}/.gdbinit",
                ignoreFailures = "true",
            },
            {
                text = "-enable-pretty-printing",
                description = "enable pretty printing",
                ignoreFailures = false,
            },
        },
    },
}

dap.configurations.rust = dap.configurations.c
dap.configurations.cpp = dap.configurations.c
