{
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf (!config.mvim.small) {
  plugins = {
    lsp.servers.ltex_plus = {
      enable = true;
      package = pkgs.ltex-ls-plus;
      # https://github.com/nix-community/nixvim/issues/2361
      filetypes = [
        "gitcommit"
        "mail"
        "markdown"
        "pandoc"
        "text"
        "typst"
      ];
      autostart = false;
      settings = {
        # enable for all markup files
        # (not source code files)
        enabled = true;
        language = "en-US";
      };
      onAttach.function = builtins.readFile ./ltex_attach.lua;
    };

    ltex-extra = {
      enable = true;
      settings = {
        load_langs = [
          "en-US"
          "sv"
        ];
        path.__raw =
          # lua
          ''vim.fn.expand("~") .. "/.local/share/ltex"'';
      };
    };

    # TODO: https://github.com/barreiroleo/ltex_extra.nvim/pull/66
    # Plus new nixvim config needed to load with ltex-ls-plus
    # ltex-extra = {
    #   enable = true;
    #   settings = {
    #     load_langs = [
    #       "en-US"
    #       "sv"
    #     ];
    #     path.__raw =
    #       # lua
    #       ''vim.fn.expand("~") .. "/.local/share/ltex"'';
    #   };
    # };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>lt";
      action.__raw = ''
        function() 
          local server_name = "ltex_plus"
          local bufnr = vim.api.nvim_get_current_buf()
          local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
          for _, client in ipairs(clients) do
            if client.name == server_name then
              vim.notify("Stopping LTeX-ls", "info")
              vim.api.nvim_command('LspStop ' .. client.id)
              return
            end
          end
          vim.notify("Starting LTeX-ls", "info")
          vim.api.nvim_command('LspStart ' .. server_name)
        end
      '';
      options = {
        silent = true;
        desc = "LSP: toggle LTeX";
      };
    }
  ];

}
