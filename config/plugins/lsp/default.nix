{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.mvim) small;
in
{
  imports = [ ./ltex.nix ];

  plugins.clangd-extensions = {
    enable = true;
    inlayHints = {
      parameterHintsPrefix = "ᐊ ";
      otherHintsPrefix = "» ";
    };
  };

  plugins.rustaceanvim = {
    enable = true;
    # Install rust-analyzer per project
    rustAnalyzerPackage = null;

    # NOTE: 'server.settings' dosent work...
    # https://github.com/nix-community/nixvim/issues/1258 
    settings = {
      server.default_settings.rust-analyzer = {
        cargo = {
          allTargets = true;
          features = "all";
        };
        check = {
          command = "clippy";
          extraArgs = [ "--no-deps" ];
        };
      };
      tools = {
        crate_test_executor = "toggleterm";
        executor = "toggleterm";
      };
    };
  };

  plugins.lsp = {
    enable = true;
    inlayHints = true;
    # https://github.com/neovim/nvim-lspconfig/issues/2184
    # capabilities = "capabilities.offsetEncoding = 'utf-16'";
    servers = {
      clangd = {
        enable = true;
        # Defaults includes .proto
        filetypes = [
          "c"
          "cpp"
          "objc"
          "objcpp"
          "cuda"
        ];
        package = lib.mkIf small null;
      };
      hls = {
        enable = true;
        # Install per project
        package = null;
        installGhc = false;
      };
      tinymist = {
        enable = true;
        settings = {
          exportPdf = "never";
          formatterMode = "typstyle";
        };
      };
      bashls.enable = true;
      cmake.enable = true;
      pyright.enable = !small;
      ruff.enable = true;
      # Large size
      yamlls.enable = !small;
      taplo.enable = true;
      nixd = {
        enable = true;
        settings = {
          diagnostic.suppress = [ "sema-escaping-with" ];
          formatting.command = [ "${pkgs.nixfmt-rfc-style}/bin/nixfmt" ];
        };
        # onAttach.function = # lua
        #   ''
        #     client.server_capabilities.semanticTokensProvider = nil
        #   '';
      };
    };

    onAttach =
      # lua
      ''
        -- Turn on signcolumn for the current window
        vim.wo.signcolumn = "yes"

        -- Update code lenses
        if client.server_capabilities.codeLensProvider then
            local group_id = vim.api.nvim_create_augroup(("_lsp_codelens_%d"):format(bufnr), { clear = true })
            vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "InsertLeave" }, {
                buffer = bufnr,
                callback = function() vim.lsp.codelens.refresh({ bufnr = bufnr }) end,
                group = group_id,
            })
        end
      '';

    keymaps =
      let
        action = {
          action = "code_action";
          desc = "LSP: code action";
        };
        rename = {
          action = "rename";
          desc = "LSP: rename";
        };
      in
      {
        silent = true;
        lspBuf = {
          "gd" = {
            action = "definition";
            desc = "LSP: definition";
          };

          "gi" = {
            action = "implementation";
            desc = "LSP: implementation";
          };

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

          # Dual mapping to for old habits
          "<leader>la" = action;
          "<leader>a" = action;
          "<leader>lr" = rename;
          "<leader>r" = rename;
        };
      };
  };

  keymaps = [
    {
      mode = "n";
      key = "]d";
      action.__raw = # lua
        "function() vim.diagnostic.goto_next({float = true}) end";
      options = {
        silent = true;
        desc = "Diagnostic: next";
      };
    }

    {
      mode = "n";
      key = "[d";
      action.__raw = # lua
        "function() vim.diagnostic.goto_prev({float = true}) end";
      options = {
        silent = true;
        desc = "Diagnostic: prev";
      };
    }

    {
      mode = "n";
      key = "<leader>lf";
      action.__raw = "vim.lsp.buf.format";
      options = {
        silent = true;
        desc = "LSP: format buffer";
      };
    }

    {
      mode = "n";
      key = "<leader>li";
      action.__raw =
        # lua
        ''
          function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
          end
        '';
      options = {
        # silent = true;
        desc = "LSP: toggle inlay hints";
      };
    }

    {
      mode = "n";
      key = "<leader>ll";
      action.__raw = "vim.lsp.codelens.run";
      options = {
        silent = true;
        desc = "LSP: run codelens";
      };
    }

    {
      mode = "n";
      key = "<leader>ls";
      action = "<cmd>ClangdSwitchSourceHeader<cr>";
      options = {
        silent = true;
        desc = "Clangd: switch to/from header";
      };
    }
  ];

  plugins.which-key.settings.spec = [
    {
      __unkeyed-1 = "<leader>l";
      icon = " ";
      group = "LSP";
    }
  ];

  plugins.fidget.enable = true;

  plugins.nvim-lightbulb.enable = true;
}
