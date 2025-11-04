{
  plugins.fzf-lua = {
    enable = true;
    settings.winopts.backdrop = 80;
    profile.__raw = "'ivy'";
    luaConfig.pre = ''
      require('fzf-lua').register_ui_select()
    '';

    keymaps = {
      "<leader>\\" = {
        options.desc = "Fzf: builtin";
        action = "builtin";
        settings.winopts = {
          row = 0.0;
          col = 0.5;
        };
      };

      "<leader><leader>" = {
        options.desc = "Fzf: resume";
        action = "resume";
      };

      "<leader>/" = {
        options.desc = "Grep";
        action = "live_grep";
      };

      "<leader>f" = {
        options.desc = "Find files";
        action = "files";
      };

      "<leader>F" = {
        options.desc = "Find git files";
        action = "git_files";
      };

      "<leader>b" = {
        options.desc = "Buffers";
        action = "buffers";
      };

      "<leader>gg" = {
        options.desc = "Git status";
        action = "git_status";
      };

      "<leader>lr" = {
        options.desc = "LSP: references";
        action = "lsp_references";
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
        options.desc = "Document diagnostics";
        action = "diagnostics_document";
      };

      "<leader>lD" = {
        options.desc = "Workspace diagnostics";
        action = "diagnostics_workspace";
      };

      "z=" = {
        options.desc = "Spell suggestions";
        action = "spell_suggest";
      };
    };
  };
}
