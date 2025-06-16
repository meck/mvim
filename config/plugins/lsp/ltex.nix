{
  lib,
  config,
  pkgs,
  ...
}:

# NOTE: Switched to new `.lsp` config for ltex as there was issues with
# `activate=false` under `Plugins.lsp`. ltex_extra is not yet available
# under the new config, so replicating the old setup manually here for now.
let
  ltexExtraCfg = {
    load_langs = [
      "en-US"
      "sv"
    ];
    path.__raw =
      # lua
      ''vim.fn.expand("~") .. "/.local/share/ltex"'';
  };
in

lib.mkIf (!config.mvim.small) {
  lsp.servers.ltex = {
    enable = true;
    package = pkgs.ltex-ls-plus;
    activate = false;
    settings = {
      cmd = [ "ltex-ls-plus" ];
      filetypes = [
        "asciidoc"
        "gitcommit"
        "mail"
        "markdown"
        "pandoc"
        "text"
        "typst"
      ];
      settings = {
        # enable for all markup files
        # (not source code files)
        enabled = true;
        language = "en-US";
      };
      on_attach.__raw = # lua
        ''
          function(client, bufnum)
             ${builtins.readFile ./ltex_attach.lua}
             require("ltex_extra").setup(${lib.nixvim.toLuaObject ltexExtraCfg})
          end
        '';

    };
  };

  extraPlugins = [ pkgs.vimPlugins.ltex_extra-nvim ];

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
