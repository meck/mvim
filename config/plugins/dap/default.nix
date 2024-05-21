{
  pkgs,
  lib,
  config,
  ...
}:
lib.mkIf (!config.mvim.small) {
  # Put the configurations in lua for now
  extraConfigLuaPost = builtins.readFile ./dap.lua;

  plugins.dap = {
    enable = true;

    extensions.dap-ui.enable = true;

    adapters = {
      executables = {
        cppdbg = {
          id = "cppdbg";
          command = "OpenDebugAD7";
        };
        lldb = {
          id = "cppdbg";
          command = "lldb-vscode";
        };
      };

      servers = {
        codelldb = {
          port = ''''${port}'';
          executable = {
            command = "codelldb";
            args = [
              "--port"
              ''''${port}''
            ];
          };
        };
      };
    };

    signs = {
      dapBreakpoint = {
        text = " ";
        texthl = "DiagnosticInfo";
      };
      dapBreakpointCondition = {
        text = " ";
        texthl = "DiagnosticInfo";
      };
      dapBreakpointRejected = {
        text = " ";
        texthl = "DiagnosticError";
      };
      dapLogPoint = {
        text = " ";
        texthl = "DiagnosticInfo";
      };
      dapStopped = {
        text = "󰁕 ";
        texthl = "DiagnosticWarn";
        linehl = "DapStoppedLine";
        numhl = "DapStoppedLine";
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>db";
      action = "require('dap').toggle_breakpoint";
      lua = true;
      options = {
        silent = true;
        desc = "Dap: toggle breakpoint";
      };
    }

    {
      mode = "n";
      key = "<leader>dc";
      action = "require('dap').continue";
      lua = true;
      options = {
        silent = true;
        desc = "Dap: continue";
      };
    }

    {
      mode = "n";
      key = "<leader>dn";
      action = "require('dap').step_over";
      lua = true;
      options = {
        silent = true;
        desc = "Dap: step over";
      };
    }

    {
      mode = "n";
      key = "<leader>dj";
      action = "require('dap').step_into";
      lua = true;
      options = {
        silent = true;
        desc = "Dap: step into";
      };
    }

    {
      mode = "n";
      key = "<leader>dk";
      action = "require('dap').step_out";
      lua = true;
      options = {
        silent = true;
        desc = "Dap: step out";
      };
    }

    {
      mode = "n";
      key = "<leader>dr";
      action = "require('dap').run_to_cursor";
      lua = true;
      options = {
        silent = true;
        desc = "Dap: run to cursor";
      };
    }

    {
      mode = "n";
      key = "<leader>dx";
      action = "require('dap').terminate";
      lua = true;
      options = {
        silent = true;
        desc = "Dap: terminate";
      };
    }

    {
      mode = "n";
      key = "<leader>dd";
      action = "require('dapui').toggle";
      lua = true;
      options = {
        silent = true;
        desc = "Dap: toggle ui";
      };
    }
  ];

  extraPackages =
    with pkgs;
    let
      vscode-cpptools = runCommand "vscode-cpptools" { } ''
        mkdir -p $out/bin
        ln -s ${vscode-extensions.ms-vscode.cpptools}/share/vscode/extensions/ms-vscode.cpptools/debugAdapters/bin/OpenDebugAD7 \
          $out/bin/
      '';

      vscode-codelldb = runCommand "codelldb" { } ''
        mkdir -p $out/bin
        ln -s ${vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb \
          $out/bin/
      '';
    in
    [ lldb ]
    # Only available/building on x86_64-linux
    ++ lib.optionals (stdenv.isLinux && stdenv.isx86_64) [
      vscode-cpptools
      vscode-codelldb
    ];
}
