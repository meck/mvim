_: {
  plugins = {
    copilot-lua = {
      enable = true;
      suggestion = {
        autoTrigger = false;
        keymap = {
          accept = "<M-l>";
          prev = "<M-[>";
          next = "<M-]>";
          dismiss = "<C-]>";
        };
      };
    };
    copilot-chat = {
      enable = true;
      settings = {
        window.layout = "horizontal";
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
            local input = vim.fn.input("Quick Chat (Buffer): ")
            if input ~= "" then
              require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
            end
          end
        '';
      options.desc = "CopilotChat: Quick chat";
    }

    {
      mode = [
        "v"
        "n"
      ];
      key = "<leader>ch";
      action.__raw = # lua
        ''
          function()
            require('CopilotChat.integrations.telescope').pick(require('CopilotChat.actions').help_actions())
          end
        '';
      options.desc = "CopilotChat: Quick help";
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
            require('CopilotChat.integrations.telescope').pick(require("CopilotChat.actions").prompt_actions({}))
          end
        '';

      options.desc = "CopilotChat: Quick prompt actions";
    }
  ];
}
