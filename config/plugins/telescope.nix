{ pkgs, ... }:
{
  plugins.telescope = {
    enable = true;
    settings = {
      defaults = {
        prompt_prefix = "󰄾  ";
        selection_caret = " ";
        multi_icon = "┃";
        mappings.i."<esc>".__raw = # lua
          ''
            function(...)
              return require("telescope.actions").close(...)
            end
          '';
      };
      pickers = {
        builtin = {
          theme = "dropdown";
          preview.hide_on_startup = true;
          include_extensions = true;
          use_default_opts = true;
        };
        autocommands.theme = "ivy";
        buffers.theme = "ivy";
        colorscheme.theme = "ivy";
        command_history.theme = "ivy";
        commands.theme = "ivy";
        diagnostics.theme = "ivy";
        filetypes.theme = "ivy";
        find_files.theme = "ivy";
        git_buffers.theme = "ivy";
        git_files.theme = "ivy";
        git_status.theme = "ivy";
        help_tags.theme = "ivy";
        highlights.theme = "ivy";
        keymaps.theme = "ivy";
        live_grep.theme = "ivy";
        loclist.theme = "ivy";
        lsp_definitions.theme = "ivy";
        lsp_document_symbols = "ivy";
        lsp_implementations.theme = "ivy";
        lsp_references.theme = "ivy";
        lsp_type_definitions.theme = "ivy";
        lsp_workspace_symbols = "ivy";
        man_pages.theme = "ivy";
        quickfix.theme = "ivy";
        quickfixhistory.theme = "ivy";
        search_history.theme = "ivy";
        spell_suggest.theme = "cursor";
      };
    };

    extensions = {
      ui-select = {
        enable = true;
        settings.__raw = # lua
          "{ require('telescope.themes').get_dropdown({ previewer = false }) }";
      };
      undo = {
        enable = true;
        settings.useDelta = true;
      };
    };

    keymaps = {
      "<leader><leader>" = {
        options.desc = "Telescope: builtin";
        action = "builtin";
      };

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

      "<leader>u" = {
        options.desc = "Telescope: undo history";
        action = "undo";
      };

      "z=" = {
        options.desc = "Telescope: spell suggest";
        action = "spell_suggest";
      };

    };
  };

  # For undo extension
  extraPackages = with pkgs; [ delta ];
}
