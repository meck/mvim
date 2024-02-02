{
  keymaps = [
    {
      # Clear search highlight with <esc>
      mode = "n";
      key = "<esc>";
      action = "<cmd>:nohlsearch<cr><esc>";
      options.silent = true;
    }

    {
      # Terminal exit
      mode = "t";
      key = "<esc>";
      action = "<C-\\><C-n>";
      options.silent = true;
    }

    # Reselect visual after indenting
    {
      mode = "v";
      key = "<";
      action = "<gv";
      options.silent = true;
    }

    {
      mode = "v";
      key = ">";
      action = ">gv";
      options.silent = true;
    }

    # Tab Navigation
    {
      mode = "n";
      key = "tn";
      action = ":tabnew<cr>";
      options = {
        silent = true;
        desc = "New Tab";
      };
    }

    {
      mode = "n";
      key = "td";
      action = ":tabclose<cr>";
      options = {
        silent = true;
        desc = "Close Tab";
      };
    }

    {
      mode = "n";
      key = "th";
      action = ":tabprev<cr>";
      options = {
        silent = true;
        desc = "Previous Tab";
      };
    }

    {
      mode = "n";
      key = "tl";
      action = ":tabnext<cr>";
      options = {
        silent = true;
        desc = "Next Tab";
      };
    }

    {
      mode = "n";
      key = "tk";
      action = ":+tabmove<cr>";
      options = {
        silent = true;
        desc = "Move Tab Left";
      };
    }

    {
      mode = "n";
      key = "tj";
      action = ":-tabmove<cr>";
      options = {
        silent = true;
        desc = "Move Tab Right";
      };
    }

    # Echo updated fold levels
    {
      mode = "n";
      key = "zr";
      action = "zr:echo 'Foldlevel = ' . &foldlevel<cr>";
      options.silent = true;
    }

    {
      mode = "n";
      key = "zm";
      action = "zm:echo 'Foldlevel = ' . &foldlevel<cr>";
      options.silent = true;
    }

    {
      mode = "n";
      key = "zR";
      action = "zR:echo 'Foldlevel = ' . &foldlevel<cr>";
      options.silent = true;
    }

    {
      mode = "n";
      key = "zM";
      action = "zM:echo 'Foldlevel = ' . &foldlevel<cr>";
      options.silent = true;
    }

    {
      mode = "c";
      key = "w!!";
      action = "w !sudo tee >/dev/null %";
      options = {
        silent = false;
        desc = "sudo save";
      };
    }

    # Swedish keymap
    {
      mode = "n";
      key = "<leader>s";
      action = "_G.swe_mode_toggle";
      lua = true;
      options = {
        silent = false;
        desc = "Toggle swedish keymap";
      };
    }
  ];
}
