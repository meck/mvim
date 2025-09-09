_: {
  plugins = {
    copilot-lua = {
      enable = true;
      settings = {
        suggestion = {
          autoTrigger = false;
          keymap = {
            accept = "<M-l>";
            prev = "<M-[>";
            next = "<M-]>";
            dismiss = "<C-]>";
          };
        };
        filetypes = {
          "." = false;
          help = false;
        };
      };
    };
    copilot-chat = {
      enable = true;
      settings = {
        headers = {
          user = "󱜸  You: ";
          assistant = "  Copilot: ";
          tool = "  Tool: ";
        };
        window.layout = "horizontal";
        show_folds = false;
        show_help = false;
        mappings = {
          # default C-l
          reset = {
            insert = "<C-x>";
            normal = "<C-x>";
          };
        };
      };
    };
    which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>c";
        icon = " ";
        group = "Copilot";
      }
    ];
  };

  autoCmd = [
    {
      event = [ "BufEnter" ];
      pattern = [ "copilot-*" ];
      callback = {
        __raw = ''
          function()
            vim.opt_local.number = false
            vim.opt_local.signcolumn = "no"
          end
        '';
      };
    }
  ];

  keymaps = [
    {
      mode = "n";
      key = "<leader>ct";
      action.__raw = # lua
        "require('copilot.suggestion').toggle_auto_trigger";
      options.desc = "Copilot: Toggle auto trigger";
    }

    {
      mode = "n";
      key = "<leader>cc";
      action.__raw = # lua
        "require('CopilotChat').toggle";
      options.desc = "CopilotChat: Toggle";
    }

    {
      mode = "n";
      key = "<leader>cm";
      action.__raw = # lua
        "require('CopilotChat').select_model";
      options.desc = "CopilotChat: Select model";
    }

    {
      mode = [
        "v"
        "n"
      ];
      key = "<leader>cq";
      action.__raw = # lua
        ''
          function()
            local mode = vim.api.nvim_get_mode().mode
            local sel, label
            if mode == "v" or mode == "V" or mode == "\22" then
              sel = require("CopilotChat.select").visual
              label = "Selection"
            else
              sel = require("CopilotChat.select").buffer
              label = "Buffer"
            end
            vim.ui.input({ prompt = "Quick Chat (" .. label .."): " }, function(input)
              if input ~= nil and input ~= "" then
                require("CopilotChat").ask(input, { selection = sel })
              end
            end)
          end
        '';
      options.desc = "CopilotChat: Quick chat";
    }

    {
      mode = [
        "v"
        "n"
      ];
      key = "<leader>cp";
      action.__raw = # lua
        ''
          function()
            local mode = vim.api.nvim_get_mode().mode
            local sel
            if mode == "v" or mode == "V" or mode == "\22" then
              sel = require("CopilotChat.select").visual
            else
              sel = require("CopilotChat.select").buffer
            end
            require("CopilotChat").select_prompt({ selection = sel })
          end
        '';

      options.desc = "CopilotChat: Prompt actions";
    }
  ];
}
