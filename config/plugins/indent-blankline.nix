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
                local ibl = require 'ibl'
                if vim.v.option_type == "local" then
                    if vim.v.option_new == true then
                        ibl.setup_buffer(buf, { enabled = true })
                    else
                        ibl.setup_buffer(buf, { enabled = false })
                    end
                end
            end
          '';
      };
    }
  ];
}
