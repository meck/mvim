{pkgs, ...}: {
  imports = [
    ./comment-nvim.nix
    ./completion
    ./copilot.nix
    ./dap
    ./git
    ./indent-blankline.nix
    ./lsp
    ./lualine.nix
    ./neogen.nix
    ./none-ls
    ./notify.nix
    ./nvim-autopairs.nix
    ./nvim-osc52.nix
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
