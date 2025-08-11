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
      action = "<CMD>CopilotChatToggle<CR>";
      options.desc = "CopilotChat: Toggle";
    }

    {
      mode = "n";
      key = "<leader>cq";
      action.__raw = # lua
        ''
          function()
            vim.ui.input({ prompt = "Quick Chat (Buffer): " }, function(input)
              if input ~= nil and input ~= "" then
                require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
              end
            end)
          end 
        '';
      options.desc = "CopilotChat: Quick chat";
    }

    {
      mode = "v";
      key = "<leader>cq";
      action.__raw = # lua
        ''
          function()
            vim.ui.input({ prompt = "Quick Chat (Selection): " }, function(input)
              if input ~= nil and input ~= "" then
                require("CopilotChat").ask(input, { selection = require("CopilotChat.select").visual })
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
            -- check if we are in a visual mode
            local mode = vim.fn.visualmode()
            if mode == "V" or mode == "v" or mode == "\22" then
              -- visual mode
              require('CopilotChat.integrations.telescope').pick(require("CopilotChat.actions").prompt_actions({
                selection = require("CopilotChat.select").visual
              }))
            else
              -- normal mode
              require('CopilotChat.integrations.telescope').pick(require("CopilotChat.actions").prompt_actions({
                selection = require("CopilotChat.select").buffer
              }))
            end
          end
        '';

      options.desc = "CopilotChat: Quick prompt actions";
    }
  ];
}
