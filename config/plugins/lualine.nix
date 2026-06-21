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
        harperStatus = {
          __unkeyed-1.__raw =
            # lua
            ''
              function()
                local bufnr = vim.api.nvim_get_current_buf()
                if vim.tbl_isempty(vim.lsp.get_clients({bufnr = bufnr, name = "harper_ls" })) then
                  return ""
                end
                return ""
              end,
            '';
        };
      in
      {
        options = {
          always_show_tabline = false;
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
            harperStatus
            "overseer"
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
        tabline = {
          lualine_a = [
            {
              __unkeyed-1 = "tabs";
              mode = 2;
              path = 0;
              show_modified_status = false;
              use_mode_colors = true;
            }
          ];
        };
      };
  };

  plugins.navic = {
    enable = true;
    settings.lsp.autoAttach = true;
  };
}
