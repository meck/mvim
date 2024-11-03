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
      group = "Markdown";
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
          desc = "MD: Toggle render-markdown";
        };
      }
      {
        mode = "v";
        key = "<leader>mt";
        action = ":! tr -s ' ' | column -t -s '|' -o '|'<CR>";
        options = {
          silent = true;
          desc = "MD: Format selected table";
        };
      }
    ]
    ++ lib.optionals (!small) [

      {
        mode = "n";
        key = "<leader>mp";
        action = "<Plug>MarkdownPreviewToggle";
        options = {
          silent = true;
          desc = "MD: Toggle browser preview";
        };
      }
    ];

}
