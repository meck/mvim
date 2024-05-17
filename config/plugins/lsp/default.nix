{ config, lib, ... }:
let
  inherit (config.mvim) small;
  inlayHintsCfg = {
    highlight = "LspCodeLens";
    parameterHintsPrefix = "ᐊ ";
    otherHintsPrefix = "» ";
  };
in
{
  imports = [ ./ltex.nix ];

  plugins.clangd-extensions = {
    enable = true;
    inlayHints = inlayHintsCfg;
  };

  plugins.rustaceanvim = {
    # TODO: Add inlay hints in vim 0.10
    enable = true;
    # Install rust-analyzer per project
    rustAnalyzerPackage = null;

    # NOTE: 'server.settings' dosent work...
    # https://github.com/nix-community/nixvim/issues/1258 
    extraOptions.server.default_settings = {
      checkOnSave = true;
      cargo.features = "all";
      check.command = "clippy";
    };
    tools = {
      crateTestExecutor = "toggleterm";
      executor = "toggleterm";
    };
  };

  plugins.lsp = {
    enable = true;
    # https://github.com/neovim/nvim-lspconfig/issues/2184
    capabilities = "capabilities.offsetEncoding = 'utf-16'";
    servers = {
      clangd = {
        enable = true;
        # Enable inlay hints from clangd-extensions by default
        onAttach.function = "require('clangd_extensions.inlay_hints').set_inlay_hints()";
        package = lib.mkIf small null;
      };
      hls = {
        enable = true;
        # Install per project
        package = null;
      };
      typst-lsp = {
        enable = true;
        extraOptions.settings.exportPdf = "never";
      };
      bashls.enable = true;
      cmake.enable = true;
      pyright.enable = true;
      ruff.enable = true;
      # Large size
      yamlls.enable = !small;
      taplo.enable = true;
      nil_ls.enable = true;
    };

    onAttach =
      # lua
      ''
        -- Turn on signcolumn for the current window
        vim.wo.signcolumn = "yes"

        -- Highlight item under the cursor
        if client.server_capabilities.documentHighlightProvider then
            local group_id = vim.api.nvim_create_augroup(("_lsp_highlight_%d"):format(bufnr), { clear = true })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = bufnr,
                callback = vim.lsp.buf.document_highlight,
                group = group_id,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved" }, {
                buffer = bufnr,
                callback = vim.lsp.buf.clear_references,
                group = group_id,
            })
        end

        -- Update code lenses
        if client.server_capabilities.codeLensProvider then
            local group_id = vim.api.nvim_create_augroup(("_lsp_codelens_%d"):format(bufnr), { clear = true })
            vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "InsertLeave" }, {
                buffer = bufnr,
                callback = vim.lsp.codelens.refresh,
                group = group_id,
            })
        end
      '';

    keymaps = {
      silent = true;
      diagnostic = {
        "]s" = {
          action = "goto_next";
          desc = "Diagnstics: next";
        };
        "[s" = {
          action = "goto_prev";
          desc = "Diagnostic: prev";
        };
      };
      lspBuf = {
        "gD" = {
          action = "declaration";
          desc = "LSP: declaration";
        };

        "gy" = {
          action = "type_definition";
          desc = "LSP: type definition";
        };

        "gs" = {
          action = "signature_help";
          desc = "LSP: signature help";
        };

        "K" = {
          action = "hover";
          desc = "LSP: hover";
        };

        "<leader>a" = {
          action = "code_action";
          desc = "LSP: code action";
        };

        "<leader>r" = {
          action = "rename";
          desc = "LSP: rename";
        };
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>gq";
      action = "vim.lsp.buf.format";
      lua = true;
      options = {
        silent = true;
        desc = "LSP: format buffer";
      };
    }

    {
      mode = "n";
      key = "<leader>c";
      action = "vim.lsp.codelens.run";
      lua = true;
      options = {
        silent = true;
        desc = "LSP: run codelens";
      };
    }

    {
      mode = "n";
      key = "ga";
      action = "<cmd>ClangdSwitchSourceHeader<cr>";
      options = {
        silent = true;
        desc = "Clangd: switch to/from header";
      };
    }
  ];

  plugins.fidget.enable = true;

  plugins.nvim-lightbulb.enable = true;
}
