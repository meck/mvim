{ ... }:
{
  autoCmd = [
    {
      event = [ "FileType" ];
      pattern = [
        "sh"
        "bash"
      ];
      desc = "Set bash shiftwidth to 4 instead of 2";
      callback.__raw = # lua
        ''
          function()
              vim.bo.shiftwidth = 4
              vim.bo.tabstop = 4
              vim.bo.softtabstop = 4
              vim.bo.expandtab = true
            end
        '';
    }

    {
      event = [ "FileType" ];
      pattern = [ "lua" ];
      desc = "Set lua shiftwidth to 4 instead of 2";
      callback.__raw = # lua
        ''
          function()
              vim.bo.shiftwidth = 4
              vim.bo.tabstop = 4
              vim.bo.softtabstop = 4
              vim.bo.expandtab = true
            end
        '';
    }

    {
      event = [ "FileType" ];
      pattern = [ "dts" ];
      desc = "Use tabs for dts";
      callback.__raw = # lua
        ''
          function()
              vim.bo.shiftwidth = 8
              vim.bo.tabstop = 8
              vim.bo.softtabstop = 8
              vim.bo.expandtab = false
            end
        '';
    }

  ];
}
