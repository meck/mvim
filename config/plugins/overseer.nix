{ ... }:
{
  plugins.overseer = {
    enable = true;
    settings.task_list.keymaps = {
      "<C-j>" = false; # "ScrollOutputDown";
      "<C-k>" = false; # "ScrollOutputUp";
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>o";
      action = "<cmd>:OverseerToggle!<cr>";
      options = {
        desc = "Overseer Toggle";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<C-b>";
      action = "<cmd>:OverseerRun<cr>";
      options = {
        desc = "Overseer Run";
        silent = true;
      };
    }
  ];

  plugins.which-key.settings.spec = [
    {
      __unkeyed-1 = "<leader>o";
      icon = "󰑮 ";
      group = "Overseer";
    }
  ];

  plugins.lualine.settings.extensions = [ "overseer" ];

}
