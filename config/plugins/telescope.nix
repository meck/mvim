{pkgs, ...}: {
  plugins.telescope = {
    enable = true;
    extraOptions = {
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
        useDelta = true;
      };
    };

    keymaps = {
      "<leader>/" = {
        desc = "Telescope: grep";
        action = "live_grep";
      };

      "<leader>f" = {
        desc = "Telescope: files";
        action = "find_files";
      };

      "<leader>F" = {
        desc = "Telescope: git files";
        action = "git_files";
      };

      "<leader>b" = {
        desc = "Telescope: buffers";
        action = "buffers";
      };

      "<leader>g" = {
        desc = "Telescope: git status";
        action = "git_status";
      };

      "<leader>gd" = {
        desc = "LSP: definitions";
        action = "lsp_definitions";
      };

      "<leader>gi" = {
        desc = "LSP: implementations";
        action = "lsp_implementations";
      };

      "<leader>ls" = {
        desc = "LSP: symbols";
        action = "lsp_document_symbols";
      };

      "<leader>lS" = {
        desc = "LSP: workspace symbols";
        action = "lsp_workspace_symbols";
      };

      "<leader>ld" = {
        desc = "Telescope: diagnostics";
        action = "diagnostics";
      };
    };
  };
  keymaps = [
    {
      mode = "n";
      key = "<leader><leader>";
      lua = true;
      action =
        /*
        lua
        */
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
      lua = true;
      action = "require('telescope').extensions.undo.undo";
      options = {
        silent = true;
        desc = "Telescope: undo history";
      };
    }
  ];

  # For undo extension
  extraPackages = with pkgs; [delta];
}
