{
  config = {
    opts = {
      # Misc
      timeoutlen = 500;
      ttimeoutlen = 50;
      mouse = "a";
      undofile = true;
      foldlevelstart = 99;
      updatetime = 200;

      # Local RC
      exrc = true;
      secure = true;

      # Visual
      showmode = false;
      visualbell = true;
      listchars = {
        space = "·";
        tab = "▸ ";
        eol = "¬";
      };
      linebreak = true;
      number = true;

      # Searching
      ignorecase = true;
      smartcase = true;

      # Indentation defaults
      smartindent = true;
      expandtab = true;
      softtabstop = 2;
      shiftwidth = 2;

      # Scrolling
      scrolloff = 10;
      sidescrolloff = 5;

      # Completion
      wildmode = "longest:list,full";
      completeopt = "menu,menuone,noselect";

      clipboard = [ "unnamedplus" ];
    };

    globals = {
      # Leader keys <space> and \
      mapleader = "\ ";
      maplocalleader = "\\";
    };

    autoCmd = [
      {
        desc = "Enable relative line numbers in normal mode";
        event = [
          "BufEnter"
          "FocusGained"
          "InsertLeave"
          "WinEnter"
        ];
        callback = {
          __raw = ''
            function()
              if vim.o.nu and vim.fn.mode() ~= "i" then
                vim.o.rnu = true
              end
            end
          '';
        };
      }

      {
        desc = "Disable relative line numbers in insert mode";
        event = [
          "BufLeave"
          "FocusLost"
          "InsertEnter"
          "WinLeave"
        ];
        callback = {
          __raw = ''
            function()
               if vim.o.nu then
                 vim.o.rnu = false
               end
            end
          '';
        };
      }

      {
        desc = "Highlight on yank";
        event = [ "TextYankPost" ];
        callback = {
          __raw = ''
            function()
              vim.highlight.on_yank({
                higroup = "Search",
                timeout = 350,
              })
            end
          '';
        };
      }

      {
        desc = "Remove kitty padding on enter";
        event = [ "VimEnter" ];
        command = ":silent ![ \"x$TERM\" = \"xxterm-kitty\" ] && kitty @ set-spacing padding=0 margin=0";
      }
      {
        desc = "Restore kitty padding on leave";
        event = [ "VimLeave" ];
        command = ":silent ![ \"x$TERM\" = \"xxterm-kitty\" ] && kitty @ set-spacing padding=default margin=default";
      }
    ];

    extraConfigLuaPre =
      ''
        vim.opt.shortmess:append("c")
      ''
      + (builtins.readFile ./options.lua)
      + (builtins.readFile ./neovide.lua);

    extraFiles = {
      "keymap/swe-us_utf-8.vim".source = ../keymap/swe-us_utf-8.vim;
    };
  };
}
