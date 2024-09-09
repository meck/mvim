{
  plugins.lualine = {
    enable = true;
    settings = {
      globalstatus = true;
      alwaysDivideMiddle = true;
      extensions = [ "quickfix" ];
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
            __unkeyed-1.__raw =
              # lua
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
            __unkeyed-1.__raw =
              # lua
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
        lualine_b = [
          "branch"
          "diff"
        ];
        lualine_c = [
          "filename"
          "navic"
        ];
        lualine_x = [
          "spaces"
          "encoding"
          "filetype"
        ];
        lualine_y = [ "diagnostics" ];
        lualine_z = [
          "progress"
          "location"
        ];
      };
      inactiveSections = {
        lualine_b = [
          "branch"
          "diff"
        ];
        lualine_c = [ "filename" ];
      };
    };
  };

  plugins.navic = {
    enable = true;
    settings.lsp.autoAttach = true;
  };
}
