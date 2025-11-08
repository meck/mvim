{ pkgs, ... }:
{
  plugins.lsp.servers.nixd = {
    enable = true;
    settings = {
      formatting.command = [ "${pkgs.nixfmt}/bin/nixfmt" ];
    };
  };
}
