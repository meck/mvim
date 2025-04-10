{
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf (!config.mvim.small) {
  plugins = {
    lsp.servers.ltex = {
      enable = true;
      package = pkgs.ltex-ls-plus;
      cmd = [ "ltex-ls-plus" ];
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
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>lt";
      action.__raw = ''
        function() 
          local server_name = "ltex"
          local bufnr = vim.api.nvim_get_current_buf()
          if vim.tbl_isempty(vim.lsp.get_clients({ bufnr = bufnr, name = server_name })) then
              vim.notify("Starting LTeX-ls", "info")
              vim.api.nvim_command('LspStart ' .. server_name)
          else
              vim.notify("Stopping LTeX-ls", "info")
              vim.api.nvim_command('LspStop ' .. server_name)
          end
        end
      '';
      options = {
        silent = true;
        desc = "LSP: toggle LTeX";
      };
    }
  ];

}
