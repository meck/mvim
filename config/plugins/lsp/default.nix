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
  imports = [
    ./c.nix
    ./haskell.nix
    ./ltex.nix
    ./nix.nix
    ./rust.nix
    ./lua.nix
  ];

  plugins.lsp = {
    enable = true;

    inlayHints = true;
    servers = {
      bashls.enable = true;
      cmake.enable = true;
      jsonls.enable = !small;
      pyright.enable = !small;
      ruff.enable = true;
      taplo.enable = true;
      yamlls.enable = !small;
      dts_lsp = {
        enable = !small;
        package = pkgs.dts-lsp;
      };
    };

    onAttach =
      # lua
      ''
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

    keymaps = {
      silent = true;
      lspBuf = {

        "<leader>a" = {
          action = "code_action";
          desc = "LSP: code action";
        };

        "<leader>r" = {
          action = "rename";
          desc = "LSP: rename";
        };

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
      };
    };
  };

  extraPackages = lib.mkIf (!small) [
    # For bashls
    pkgs.shellcheck
    pkgs.shfmt
  ];

  keymaps = [
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
  ];

  plugins.which-key.settings.spec = [
    {
      __unkeyed-1 = "<leader>l";
      icon = " ";
      group = "LSP";
    }
  ];

  plugins.nvim-lightbulb.enable = true;
}
