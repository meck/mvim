{ ... }:
{
  imports = [
    ./blink-cmp.nix
    ./copilot.nix
    ./dap.nix
    ./fzf-lua.nix
    ./git
    ./guess-indent.nix
    ./illuminate.nix
    ./lsp
    ./lualine.nix
    ./markup.nix
    ./mini.nix
    ./neogen.nix
    ./none-ls
    ./nvim-tree.nix
    ./oil.nix
    ./overseer.nix
    ./tmux-navigator.nix
    ./toggleterm.nix
    ./treesitter.nix
    ./trouble.nix
    ./which-key.nix
  ];

  # Builtin plugins
  extraConfigLua = ''
    vim.cmd.packadd("nvim.undotree")
  '';

  keymaps = [
    {
      mode = "n";
      key = "<leader>u";
      action = "<cmd>:Undotree<cr>";
      options.silent = true;
    }
  ];
}
