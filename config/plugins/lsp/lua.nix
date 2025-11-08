{ pkgs, config, ... }:
{
  plugins.lsp.servers.lua_ls = {
    enable = !config.mvim.small;
    settings = {
      format.defaultConfig = {
        indent_style = "space";
        indent_size = "4";
      };
      runtime = {
        path = [
          "lua/?.lua"
          "lua/?/init.lua"
        ];
        version = "LuaJIT";
      };
      workspace = {
        checkThirdParty = false;
        library = [ "${pkgs.neovim-unwrapped}/share/nvim/runtime" ];
      };
    };
  };

}
