{
  plugins.lualine = {
    enable = true;
    settings =

      let
        filenameSec = {
          __unkeyed-1 = "filename";
          symbols = {
            modified = " ";
          };
        };
        diffSec = {
          __unkeyed-1 = "diff";
          symbols = {
            added = " ";
            modified = " ";
            removed = " ";
          };
        };
      in
      {
        options = {
          alwaysDivideMiddle = true;
          extensions = [ "quickfix" ];
          component_separators = {
            left = "";
            right = "";
          };
          section_separators = {
            left = "";
            right = "";
          };
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
            diffSec
          ];
          lualine_c = [
            filenameSec
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
        inactive_sections = {
          lualine_b = [
            "branch"
            diffSec
          ];
          lualine_c = [ filenameSec ];
        };
      };
  };

  plugins.navic = {
    enable = true;
    settings.lsp.autoAttach = true;
  };
}
