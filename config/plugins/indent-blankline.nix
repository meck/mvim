{
  plugins.indent-blankline = {
    enable = true;
    settings.enabled = false;
  };

  autoCmd = [
    {
      # For following vim-unimpaired list toggle `yol`
      desc = "Automatically toggle indent-blankline";
      event = [ "OptionSet" ];
      pattern = "list";
      callback = {
        __raw =
          # lua
          ''
            function()
                if vim.v.option_type == "local" then
                    if vim.v.option_new == "1" then
                        vim.cmd([[IBLEnable]])
                    else
                        vim.cmd([[IBLDisable]])
                    end
                end
            end
          '';
      };
    }
  ];
}
