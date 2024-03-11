_: {
  plugins = {
    neogit = {
      enable = true;
      settings = {
        auto_refresh = true;
        integrations.diffview = true;
      };
    };
    diffview.enable = true;
    gitsigns.enable = true;
  };

  keymaps = [
    {
      mode = "n";
      key = "gk";
      action = "require('neogit').open";
      lua = true;
      options = {
        silent = true;
        desc = "neogit: open";
      };
    }

    {
      mode = "n";
      key = "]c";
      action =
        /*
        lua
        */
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
      lua = true;
      options = {
        silent = true;
        desc = "Git: next git hunk";
      };
    }

    {
      mode = "n";
      key = "[c";
      action =
        /*
        lua
        */
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
      lua = true;
      options = {
        silent = true;
        desc = "Git: prev git hunk";
      };
    }

    {
      mode = ["n" "v"];
      key = "<leader>hs";
      action =
        /*
        lua
        */
        "package.loaded.gitsigns.stage_hunk";
      lua = true;
      options = {
        silent = true;
        desc = "Git: stage hunk";
      };
    }

    {
      mode = ["n" "v"];
      key = "<leader>hr";
      action =
        /*
        lua
        */
        "package.loaded.gitsigns.reset_hunk";
      lua = true;
      options = {
        silent = true;
        desc = "Git: reset hunk";
      };
    }

    {
      mode = "n";
      key = "<leader>hu";
      action =
        /*
        lua
        */
        "package.loaded.gitsigns.undo_stage_hunk";
      lua = true;
      options = {
        silent = true;
        desc = "Git: undo stage hunk";
      };
    }

    {
      mode = "n";
      key = "<leader>hS";
      action =
        /*
        lua
        */
        "package.loaded.gitsigns.stage_buffer";
      lua = true;
      options = {
        silent = true;
        desc = "Git: stage buffer";
      };
    }

    {
      mode = "n";
      key = "<leader>hR";
      action =
        /*
        lua
        */
        "package.loaded.gitsigns.reset_buffer";
      lua = true;
      options = {
        silent = true;
        desc = "Git: reset buffer";
      };
    }

    {
      mode = "n";
      key = "<leader>hp";
      action =
        /*
        lua
        */
        "package.loaded.gitsigns.preview_hunk";
      lua = true;
      options = {
        silent = true;
        desc = "Git: preview hunk";
      };
    }

    {
      mode = "n";
      key = "<leader>hp";
      action =
        /*
        lua
        */
        "package.loaded.gitsigns.preview_hunk";
      lua = true;
      options = {
        silent = true;
        desc = "Git: preview hunk";
      };
    }

    {
      mode = "n";
      key = "<leader>hb";
      action =
        /*
        lua
        */
        ''function() package.loaded.gitsigns.blame_line({ full = true }) end'';
      lua = true;
      options = {
        silent = true;
        desc = "Git: blame line";
      };
    }

    {
      mode = "n";
      key = "<leader>tb";
      action =
        /*
        lua
        */
        "package.loaded.gitsigns.toggle_current_line_blame";
      lua = true;
      options = {
        silent = true;
        desc = "Git: toggle blame line";
      };
    }

    {
      mode = "n";
      key = "<leader>hd";
      action =
        /*
        lua
        */
        "package.loaded.gitsigns.diffthis";
      lua = true;
      options = {
        silent = true;
        desc = "Git: diffthis";
      };
    }

    {
      mode = "n";
      key = "<leader>hD";
      action =
        /*
        lua
        */
        ''function() package.loaded.gitsigns.diffthis("~") end'';
      lua = true;
      options = {
        silent = true;
        desc = "Git: diffthis ~";
      };
    }

    {
      mode = "n";
      key = "<leader>td";
      action =
        /*
        lua
        */
        "package.loaded.gitsigns.toggle_deleted";
      lua = true;
      options = {
        silent = true;
        desc = "Git: toggle deleted";
      };
    }

    {
      mode = ["n" "x"];
      key = "ih";
      action = ":<C-U>Gitsigns select_hunk<CR>";
      options = {
        silent = true;
        desc = "Git: select hunk";
      };
    }
  ];
}
