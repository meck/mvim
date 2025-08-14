{
  config = {
    opts = {
      # Misc
      timeoutlen = 500;
      ttimeoutlen = 50;
      foldlevelstart = 99;
      updatetime = 200;

      # Local RC
      exrc = true;
      secure = true;

      # Visual
      visualbell = true;
      cursorline = false;
      listchars = {
        space = "·";
        tab = "▸ ";
        eol = "¬";
      };
      winborder = "rounded";

      # Indentation defaults
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

    diagnostic.settings = {
      virtual_text = false;
      update_in_insert = true;
      severity_sort = true;

      signs = {
        text = {
          "__rawKey__vim.diagnostic.severity.ERROR" = "";
          "__rawKey__vim.diagnostic.severity.WARN" = "";
          "__rawKey__vim.diagnostic.severity.HINT" = "󰌵";
          "__rawKey__vim.diagnostic.severity.INFO" = "";
        };
        texthl = {
          "__rawKey__vim.diagnostic.severity.ERROR" = "DiagnosticError";
          "__rawKey__vim.diagnostic.severity.WARN" = "DiagnosticWarn";
          "__rawKey__vim.diagnostic.severity.HINT" = "DiagnosticHint";
          "__rawKey__vim.diagnostic.severity.INFO" = "DiagnosticInfo";
        };
      };
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

    extraConfigLuaPre = (builtins.readFile ./options.lua) + (builtins.readFile ./neovide.lua);

    extraFiles = {
      "keymap/swe-us_utf-8.vim".source = ../keymap/swe-us_utf-8.vim;
    };
  };
}
