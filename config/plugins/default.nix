{ pkgs, ... }:
{
  imports = [
    ./completion
    ./copilot.nix
    ./dap
    ./git
    ./icons.nix
    ./indent-blankline.nix
    ./lsp
    ./lualine.nix
    ./neogen.nix
    ./none-ls
    ./notify.nix
    ./nvim-autopairs.nix
    ./nvim-tree.nix
    ./pandoc.nix
    ./surround.nix
    ./telescope.nix
    ./tmux-navigator.nix
    ./toggleterm.nix
    ./treesitter.nix
    ./trouble.nix
    ./which-key.nix
  ];

  extraPlugins = with pkgs.vimPlugins; [
    vim-unimpaired
    vim-repeat
    tabular
  ];
}
