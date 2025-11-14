{ ... }:
{
  plugins.overseer = {
    enable = true;
    settings.task_list.bindings = {
      "<C-h>" = false; # "DecreaseDetail";
      "<C-j>" = false; # "ScrollOutputDown";
      "<C-k>" = false; # "ScrollOutputUp";
      "<C-l>" = false; # "IncreaseDetail";
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>vt";
      action = "<cmd>:OverseerToggle<cr>";
      options = {
        desc = "Overseer Toggle";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>vv";
      action = "<cmd>:OverseerRun<cr>";
      options = {
        desc = "Overseer Run";
        silent = true;
      };
    }
  ];

  plugins.which-key.settings.spec = [
    {
      __unkeyed-1 = "<leader>v";
      icon = "󰑮 ";
      group = "Overseer";
    }
  ];

  plugins.lualine.settings.extensions = [ "overseer" ];

}
