{ pkgs, ... }:
{
  imports = [
    ./blink-cmp.nix
    ./copilot.nix
    ./dap
    ./git
    ./icons.nix
    ./illuminate.nix
    ./indent-blankline.nix
    ./lsp
    ./lualine.nix
    ./markdown.nix
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
