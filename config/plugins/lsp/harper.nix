{ ... }:
{
  lsp.servers.harper_ls = {
    enable = true;
    activate = false;
    config = {
      # Use the same as spell
      settings."harper-ls".userDictPath.__raw =
        # lua
        ''vim.fn.stdpath("config") .. "/spell/en.utf-8.add"'';
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>lh";
      action.__raw = ''
        function()
          local server_name = "harper_ls"
          local bufnr = vim.api.nvim_get_current_buf()
          local clients = vim.lsp.get_clients({ bufnr = bufnr, name = server_name })
          if vim.tbl_isempty(clients) then
              vim.notify("Starting Harper", vim.log.levels.INFO)
              vim.lsp.start(vim.lsp.config[server_name], { bufnr = bufnr })
          else
              vim.notify("Stopping Harper", vim.log.levels.INFO)
              for _, client in ipairs(clients) do
                  client:stop()
              end
          end
        end
      '';
      options = {
        silent = true;
        desc = "LSP: toggle Harper";
      };
    }
  ];
}
