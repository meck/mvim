_: {
  plugins = {
    neogit = {
      enable = true;
      settings = {
        graph_style.__raw =
          # lua
          ''
            vim.env.TERM == "xterm-kitty" and "kitty" or "unicode"
          '';
        auto_refresh = true;
        integrations.diffview = true;
      };
    };
    diffview.enable = true;
    gitsigns.enable = true;
    which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>g";
        group = "Git";
      }
    ];
  };

  keymaps = [
    {
      mode = "n";
      key = "gk";
      action.__raw =
        # lua
        ''
          function()
            require('neogit').open({ kind = 'replace'});
          end
        '';
      options = {
        silent = true;
        desc = "neogit: open";
      };
    }

    {
      mode = "n";
      key = "]c";
      action.__raw =
        # lua
        ''
          function()
              if vim.wo.diff then
                  return "]c"
              end
              vim.schedule(function()
                  package.loaded.gitsigns.next_hunk()
              end)
              return "<Ignore>"
          end
        '';
      options = {
        silent = true;
        desc = "Git: next git hunk";
      };
    }

    {
      mode = "n";
      key = "[c";
      action.__raw =
        # lua
        ''
          function()
              if vim.wo.diff then
                  return "[c"
              end
              vim.schedule(function()
                  package.loaded.gitsigns.prev_hunk()
              end)
              return "<Ignore>"
          end
        '';
      options = {
        silent = true;
        desc = "Git: prev git hunk";
      };
    }

    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>gs";
      action.__raw =
        # lua
        "package.loaded.gitsigns.stage_hunk";
      options = {
        silent = true;
        desc = "Git: stage hunk";
      };
    }

    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>gr";
      action.__raw =
        # lua
        "package.loaded.gitsigns.reset_hunk";
      options = {
        silent = true;
        desc = "Git: reset hunk";
      };
    }

    {
      mode = "n";
      key = "<leader>gu";
      action.__raw =
        # lua
        "package.loaded.gitsigns.undo_stage_hunk";
      options = {
        silent = true;
        desc = "Git: undo stage hunk";
      };
    }

    {
      mode = "n";
      key = "<leader>gS";
      action.__raw =
        # lua
        "package.loaded.gitsigns.stage_buffer";
      options = {
        silent = true;
        desc = "Git: stage buffer";
      };
    }

    {
      mode = "n";
      key = "<leader>gR";
      action.__raw =
        # lua
        "package.loaded.gitsigns.reset_buffer";
      options = {
        silent = true;
        desc = "Git: reset buffer";
      };
    }

    {
      mode = "n";
      key = "<leader>gp";
      action.__raw =
        # lua
        "package.loaded.gitsigns.preview_hunk";
      options = {
        silent = true;
        desc = "Git: preview hunk";
      };
    }

    {
      mode = "n";
      key = "<leader>gb";
      action.__raw =
        # lua
        "function() package.loaded.gitsigns.blame_line({ full = true }) end";
      options = {
        silent = true;
        desc = "Git: blame line";
      };
    }

    {
      mode = "n";
      key = "<leader>gB";
      action.__raw =
        # lua
        "package.loaded.gitsigns.toggle_current_line_blame";
      options = {
        silent = true;
        desc = "Git: toggle blame line";
      };
    }

    {
      mode = "n";
      key = "<leader>gd";
      action.__raw =
        # lua
        "package.loaded.gitsigns.diffthis";
      options = {
        silent = true;
        desc = "Git: diffthis";
      };
    }

    {
      mode = "n";
      key = "<leader>gD";
      action.__raw =
        # lua
        ''function() package.loaded.gitsigns.diffthis("~") end'';
      options = {
        silent = true;
        desc = "Git: diffthis ~";
      };
    }

    {
      mode = "n";
      key = "<leader>gx";
      action.__raw =
        # lua
        "package.loaded.gitsigns.toggle_deleted";
      options = {
        silent = true;
        desc = "Git: toggle deleted";
      };
    }

    {
      mode = [
        "o"
        "x"
      ];
      key = "ih";
      action = ":<C-U>Gitsigns select_hunk<CR>";
      options = {
        silent = true;
        desc = "Git: select hunk";
      };
    }
  ];
}
