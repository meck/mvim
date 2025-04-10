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
        copilotStatus = {
          __unkeyed-1.__raw =
            # lua
            ''
              function()
                if vim.b.copilot_suggestion_auto_trigger then
                  return ""
                end
                return ""
              end,
            '';
        };
        ltexStatus = {
          __unkeyed-1.__raw =
            # lua
            ''
              function()
                local bufnr = vim.api.nvim_get_current_buf()
                if vim.tbl_isempty(vim.lsp.get_clients({bufnr = bufnr, name = "ltex" })) then
                  return ""
                end
                return ""
              end,
            '';
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
            copilotStatus
            ltexStatus
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
          lualine_b = [ "branch" ];
          lualine_c = [ filenameSec ];
        };
      };
  };

  plugins.navic = {
    enable = true;
    settings.lsp.autoAttach = true;
  };
}
