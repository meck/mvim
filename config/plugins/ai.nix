{
  pkgs,
  config,
  lib,
  ...
}:
{
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

    sidekick = {
      enable = true;
      settings = {
        nes = {
          enabled = false;
          diff.show = "cursor";
        };
        cli = {
          # remove --banner
          tools.copilot.cmd = [ "copilot" ];
          mux = {
            enabled = true;
            backend = "tmux";
          };
        };
      };
    };

    which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>c";
        icon = " ";
        group = "AI";
      }
    ];

    lualine.settings.extensions = [
      {
        filetypes = [ "sidekick_terminal" ];
        sections = {
          lualine_a = [ "mode" ];
          lualine_x = [
            {
              __unkeyed-1.__raw = ''
                function()
                  local attached = require("sidekick.cli.state").get({ attached = true })
                  if #attached == 0 then
                    return
                  end
                  local tool_name = attached[1].tool.name or "Sidekick"
                  return "  " .. tool_name
                end
              '';
            }
          ];
        };
      }
    ];
  };

  extraPackages = lib.mkIf (!config.mvim.small) (
    with pkgs;
    [
      # For sidekick
      github-copilot-cli
      claude-code
    ]
  );

  keymaps = [
    {
      mode = "n";
      key = "<leader>ce";
      action.__raw = # lua
        ''
          function()
            require('copilot.suggestion').toggle_auto_trigger()
            if vim.b.copilot_suggestion_auto_trigger then
              require('sidekick.nes').enable()
            else
              require('sidekick.nes').disable()
            end
          end
        '';
      options.desc = "Copilot: Toggle auto trigger and NES";
    }

    {
      mode = "n";
      key = "<tab>";
      action.__raw = # lua
        ''
          function()
            if not require("sidekick").nes_jump_or_apply() then
              return "<Tab>"
            end
          end
        '';
      options = {
        expr = true;
        desc = "Sidekick: Goto/Apply Next Edit Suggestion";
      };
    }

    {
      mode = [
        "n"
        "t"
        "i"
        "x"
      ];
      key = "<c-.>";
      action.__raw = # lua
        "function() require('sidekick.cli').focus() end";
      options.desc = "Sidekick: Focus";
    }

    {
      mode = "n";
      key = "<leader>cc";
      action.__raw = # lua
        "function() require('sidekick.cli').toggle() end";
      options.desc = "Sidekick: Toggle CLI";
    }

    {
      mode = "n";
      key = "<leader>cs";
      action.__raw = # lua
        "function() require('sidekick.cli').select({ filter = { installed = true } }) end";
      options.desc = "Sidekick: Select CLI";
    }

    {
      mode = "n";
      key = "<leader>cd";
      action.__raw = # lua
        "function() require('sidekick.cli').close() end";
      options.desc = "Sidekick: Detach a CLI Session";
    }

    {
      mode = [
        "x"
        "n"
      ];
      key = "<leader>ct";
      action.__raw = # lua
        ''function() require('sidekick.cli').send({ msg = "{this}" }) end'';
      options.desc = "Sidekick: Send This";
    }

    {
      mode = "n";
      key = "<leader>cf";
      action.__raw = # lua
        ''function() require('sidekick.cli').send({ msg = "{file}" }) end'';
      options.desc = "Sidekick: Send File";
    }

    {
      mode = "x";
      key = "<leader>cv";
      action.__raw = # lua
        ''function() require('sidekick.cli').send({ msg = "{selection}" }) end'';
      options.desc = "Sidekick: Send Visual Selection";
    }

    {
      mode = [
        "n"
        "x"
      ];
      key = "<leader>cp";
      action.__raw = # lua
        "function() require('sidekick.cli').prompt() end";
      options.desc = "Sidekick: Select Prompt";
    }
  ];
}
