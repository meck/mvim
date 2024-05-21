{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    vimtex
    vim-pandoc
    vim-pandoc-syntax
    vim-pandoc-after
    vim-table-mode
  ];

  globals = {
    "pandoc#formatting#mode" = "hA";
    "pandoc#keyboard#sections#header_style" = "s";
    "pandoc#spell#enabled" = false;
    "pandoc#spell#default_langs" = [
      "en"
      "sv"
    ];
    "pandoc#hypertext#create_if_no_alternates_exists" = true;
    "pandoc#hypertext#autosave_on_edit_open_link" = true;
    "pandoc#after#modules#enabled" = [ "tablemode" ];
    # NOTE: https://github.com/vim-pandoc/vim-pandoc-syntax/issues/344#issuecomment-761563470
    "pandoc#syntax#codeblocks#embeds#langs" = [
      "bash=sh"
      "vhdl"
      "python"
    ];
  };

  extraConfigLua = ''
    -- GFM compatible mode
    -- single line only
    function _G.tablemode_gfm()
        vim.g.table_mode_corner = "|"
        vim.g.table_mode_corner_corner = "|"
        vim.g.table_mode_header_fillchar = "-"
    end

    -- Pandoc compatible mode
    -- multiline possible
    function _G.tablemode_pandoc()
        vim.g.table_mode_corner = "+"
        vim.g.table_mode_corner_corner = "+"
        vim.g.table_mode_header_fillchar = "="
    end

    vim.cmd([[ command! TableGfm execute 'lua tablemode_gfm()' ]])
    vim.cmd([[ command! TablePandoc execute 'lua tablemode_pandoc()' ]])

    -- Default to gfm
    _G.tablemode_gfm()
  '';
}
