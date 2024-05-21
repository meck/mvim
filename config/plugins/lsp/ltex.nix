{ lib, config, ... }:
lib.mkIf (!config.mvim.small) {
  plugins = {
    lsp.servers.ltex = {
      enable = true;
      settings = {
        enabled = [
          "markdown"
          "tex"
          "mail"
          "gitcommit"
        ];
        language = "en-US";
      };
      onAttach.function = builtins.readFile ./ltex_attach.lua;
    };

    ltex-extra = {
      enable = true;
      settings = {
        load_langs = [
          "en-US"
          "sv"
        ];
        path.__raw =
          # lua
          ''vim.fn.expand("~") .. "/.local/share/ltex"'';
      };
    };
  };
}
