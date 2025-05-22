{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (config.mvim) small;
in
{
  # Typst
  plugins.lsp.servers.tinymist = {
    enable = true;
    settings = {
      exportPdf = "never";
      formatterMode = "typstyle";
    };
  };

  plugins.typst-preview.enable = !small;

  plugins.typst-vim = {
    enable = true;
    settings.pdf_viewer = "zathura";
  };
  globals.typst_conceal = "1";

  # Markdown
  plugins.lsp.servers.marksman.enable = true;
  plugins.render-markdown.enable = true;
  plugins.markdown-preview = {
    enable = !small;
    settings = {
      auto_close = 0;
      combine_preview = 1;
    };
  };
  extraPackages = [ pkgs.python312Packages.pylatexenc ];

  plugins.which-key.settings.spec = [
    {
      __unkeyed-1 = "<leader>m";
      icon = " ";
      group = "Markdown/Typst";
    }
  ];

  keymaps =
    [
      {
        mode = "n";
        key = "<leader>mm";
        action.__raw = "require('render-markdown').toggle";
        options = {
          silent = true;
          desc = "Toggle render-markdown";
        };
      }
      {
        mode = "v";
        key = "<leader>mt";
        action = ":! tr -s ' ' | column -t -s '|' -o '|'<CR>";
        options = {
          silent = true;
          desc = "Format selected table";
        };
      }
    ]
    ++ lib.optionals (!small) [

      {
        mode = "n";
        key = "<leader>mp";
        action.__raw = ''
          function()
            local filetype = vim.bo.filetype
            if filetype == "markdown" then
              vim.cmd("MarkdownPreviewToggle")
            elseif filetype == "typst" then
              vim.cmd("TypstPreviewToggle")
            else
              vim.notify("No preview for filetype: " .. filetype, "error")
            end
          end
        '';
        options = {
          silent = true;
          desc = "Toggle browser preview";
        };
      }
    ];

}
