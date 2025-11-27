{
  pkgs,
  lib,
  config,
  ...
}:
lib.mkIf (!config.mvim.small) {

  plugins.lualine.settings.extensions = [ "nvim-dap-ui" ];

  plugins.dap = {
    enable = true;
    signs = {
      dapBreakpoint = {
        text = " ";
        texthl = "DiagnosticInfo";
      };
      dapBreakpointCondition = {
        text = " ";
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
        text = " ";
        texthl = "DiagnosticWarn";
        linehl = "DapStoppedLine";
        numhl = "DapStoppedLine";
      };
    };
  };

  plugins.dap-ui.enable = true;
  plugins.dap-virtual-text.enable = true;

  plugins.which-key.settings.spec = [
    {
      __unkeyed-1 = "<leader>d";
      group = "Debug";
    }
  ];

  keymaps = [
    {
      mode = "n";
      key = "<leader>db";
      action.__raw = # lua
        "require('dap').toggle_breakpoint";
      options = {
        silent = true;
        desc = "Toggle breakpoint";
      };
    }

    {
      mode = "n";
      key = "<leader>dc";
      action.__raw = # lua
        "require('dap').continue";
      options = {
        silent = true;
        desc = "Continue (Start)";
      };
    }

    {
      mode = "n";
      key = "<leader>ds";
      action.__raw = # lua
        "require('dap').step_over";
      options = {
        silent = true;
        desc = "Step over";
      };
    }

    {
      mode = "n";
      key = "<leader>dS";
      action.__raw = # lua
        "require('dap').step_into";
      options = {
        silent = true;
        desc = "Step into";
      };
    }

    {
      mode = "n";
      key = "<leader>do";
      action.__raw = # lua
        "require('dap').step_out";
      options = {
        silent = true;
        desc = "Step out";
      };
    }

    {
      mode = "n";
      key = "<leader>dr";
      action.__raw = # lua
        "require('dap').run_to_cursor";
      options = {
        silent = true;
        desc = "Run to cursor";
      };
    }

    {
      mode = "n";
      key = "<leader>dx";
      action.__raw = # lua
        "require('dap').terminate";
      options = {
        silent = true;
        desc = "Terminate";
      };
    }

    {
      mode = "n";
      key = "<leader>dd";
      action.__raw = # lua
        ''
          function()
            require('dap.ext.vscode').load_launchjs(nil, {})
            require("dapui").toggle()
          end
        '';
      options = {
        silent = true;
        desc = "Toggle ui";
      };
    }
  ];

  extraPackages =
    with pkgs;
    [ lldb ]
    # not building under darwin
    ++ lib.optionals (!pkgs.stdenv.isDarwin) [
      vscode-extensions.vadimcn.vscode-lldb.adapter
    ];

  extraPlugins = with pkgs.vimPlugins; [ nvim-dap-cortex-debug ];

  extraConfigLua = # lua
    ''
      require('dap-cortex-debug').setup {
          extension_path = "${pkgs.vscode-extensions.marus25.cortex-debug}/share/vscode/extensions/marus25.cortex-debug",
          node_path = "${lib.getExe pkgs.nodejs}",
      }
    '';

}
