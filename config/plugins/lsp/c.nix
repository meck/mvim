{
  config,
  lib,
  ...
}:
{
  plugins.clangd-extensions = {
    enable = true;
    settings.inlay_hints = {
      other_hints_prefix = "» ";
      parameter_hints_prefix = "» ";
    };
  };

  plugins.lsp = {
    servers = {
      clangd = {
        enable = true;
        # Defaults includes .proto
        filetypes = [
          "c"
          "cpp"
          "objc"
          "objcpp"
          "cuda"
        ];
        package = lib.mkIf config.mvim.small null;
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>ls";
      action = "<cmd>ClangdSwitchSourceHeader<cr>";
      options = {
        silent = true;
        desc = "Clangd: switch to/from header";
      };
    }
  ];
}
