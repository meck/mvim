{
  config,
  lib,
  pkgs,
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
      clangd =
        let
          # https://github.com/coletrammer/dotfiles/blob/4c6d15499037db9e165eaa2e7f1d44fe2065ea6c/home/nvim/lang/cpp.nix#L62
          # Seeing issues when using cross toolchains
          clang = pkgs.llvmPackages.libcxxClang;
          clangUnwrapped = pkgs.llvmPackages.clang-unwrapped;
          clangd = pkgs.writeShellScriptBin "clangd" ''
            export CPATH=''${CPATH}''${CPATH:+':'}:${clang}/resource-root/include
            export CPLUS_INCLUDE_PATH=''${CPLUS_INCLUDE_PATH}''${CPLUS_INCLUDE_PATH:+':'}:${clang}/resource-root/include
            exec -a "$0" ${clangUnwrapped}/bin/$(basename $0) "$@"
          '';
        in
        {
          enable = true;
          # Defaults includes .proto
          filetypes = [
            "c"
            "cpp"
            "objc"
            "objcpp"
            "cuda"
          ];
          package = lib.mkMerge [
            (lib.mkIf (!config.mvim.small) clangd)
            (lib.mkIf (config.mvim.small) null)
          ];
          cmd = [
            "clangd"
            "--background-index"
            "--clang-tidy"
            "--fallback-style=llvm"
            "--query-driver=/**/*"
          ];
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
