_: {
  plugins.mini = {
    enable = true;
    mockDevIcons = true;
    modules = {
      align = {
        mappings = {
          start = "gA";
          start_with_preview = "ga";
        };
      };
      basics = { };
      bracketed = { };
      icons = { };
      jump = {};
      pairs = { };
      surround = { };
      trailspace = { };
      indentscope = {
        symbol = "▎";
      };
    };
  };

  autoCmd = [
    {
      desc = "Disable indentscope by default";
      event = [
        "BufNew"
        "VimEnter"
      ];
      callback = {
        __raw =
          # lua
          ''
            function(args) vim.b[args.buf].miniindentscope_disable = true end
          '';
      };
    }
    {
      desc = "Automatically toggle indentscope";
      event = [ "OptionSet" ];
      pattern = "list";
      callback = {
        __raw =
          # lua
          ''
            function()
                if vim.v.option_type == "local" then
                    vim.b.miniindentscope_disable = not vim.v.option_new
                end
            end
          '';
      };
    }
  ];
}
