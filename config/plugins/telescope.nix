{ pkgs, ... }:
{
  plugins.telescope = {
    enable = true;
    settings = {
      defaults = {
        prompt_prefix = " ";
        selection_caret = " ";
        mappings = {
          i = {
            "<esc>" = {
              __raw = ''
                function(...)
                  return require("telescope.actions").close(...)
                end'';
            };
          };
        };
      };
    };

    extensions = {
      ui-select = {
        enable = true;
        settings = {
          __raw = "{ require('telescope.themes').get_dropdown({ previewer = false }) }";
        };
      };
      undo = {
        enable = true;
        settings.useDelta = true;
      };
    };

    keymaps = {
      "<leader>/" = {
        options.desc = "Telescope: grep";
        action = "live_grep";
      };

      "<leader>f" = {
        options.desc = "Telescope: files";
        action = "find_files";
      };

      "<leader>F" = {
        options.desc = "Telescope: git files";
        action = "git_files";
      };

      "<leader>b" = {
        options.desc = "Telescope: buffers";
        action = "buffers";
      };

      "<leader>gg" = {
        options.desc = "Telescope: git status";
        action = "git_status";
      };

      "<leader>lf" = {
        options.desc = "LSP: definitions";
        action = "lsp_definitions";
      };

      "<leader>li" = {
        options.desc = "LSP: implementations";
        action = "lsp_implementations";
      };

      "<leader>ls" = {
        options.desc = "LSP: symbols";
        action = "lsp_document_symbols";
      };

      "<leader>lS" = {
        options.desc = "LSP: workspace symbols";
        action = "lsp_workspace_symbols";
      };

      "<leader>ld" = {
        options.desc = "Telescope: diagnostics";
        action = "diagnostics";
      };
    };
  };
  keymaps = [
    {
      mode = "n";
      key = "<leader><leader>";
      action.__raw =
        # lua
        ''
          function()
              local theme = require("telescope.themes").get_dropdown({ previewer = false })
              require('telescope.builtin').builtin(theme)
          end
        '';
      options = {
        silent = true;
        desc = "Telescope: builtins";
      };
    }

    {
      mode = "n";
      key = "<leader>u";
      action.__raw = "require('telescope').extensions.undo.undo";
      options = {
        silent = true;
        desc = "Telescope: undo history";
      };
    }
  ];

  # For undo extension
  extraPackages = with pkgs; [ delta ];
}
