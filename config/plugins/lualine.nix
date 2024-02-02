{
  plugins.lualine = {
    enable = true;
    globalstatus = true;
    alwaysDivideMiddle = true;
    extensions = ["quickfix" "nvim-dap-ui"];
    sectionSeparators = {
      left = "";
      right = "";
    };
    componentSeparators = {
      left = "";
      right = "";
    };
    sections = {
      lualine_a = [
        "mode"
        {
          name.__raw =
            /*
            lua
            */
            ''
              function()
                local km = vim.bo.keymap
                if km ~= "" then
                    km = "  " .. km
                end
                return km
              end
            '';
        }

        {
          name.__raw =
            /*
            lua
            */
            ''
              function()
                  if vim.fn["g:tablemode#IsActive"]() == 1 then
                      return " "
                  end
                  return ""
              end
            '';
        }
      ];
      lualine_b = ["branch" "diff"];
      lualine_c = ["filename" "navic"];
      lualine_x = ["spaces" "encoding" "filetype"];
      lualine_y = ["diagnostics"];
      lualine_z = ["progress" "location"];
    };
    inactiveSections = {
      lualine_b = ["branch" "diff"];
      lualine_c = ["filename"];
    };
  };

  plugins.navic = {
    enable = true;
    lsp.autoAttach = true;
  };
}
