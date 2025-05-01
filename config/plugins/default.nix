{ pkgs, ... }:
{
  imports = [
    ./blink-cmp.nix
    ./copilot.nix
    ./dap.nix
    ./git
    ./illuminate.nix
    ./lsp
    ./lualine.nix
    ./markup.nix
    ./mini.nix
    ./neogen.nix
    ./none-ls
    ./notify.nix
    ./nvim-tree.nix
    ./oil.nix
    ./telescope.nix
    ./tmux-navigator.nix
    ./toggleterm.nix
    ./treesitter.nix
    ./trouble.nix
    ./which-key.nix
  ];

  extraPlugins = with pkgs.vimPlugins; [ vim-unimpaired ];
}
