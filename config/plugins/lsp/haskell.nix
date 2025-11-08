{ ... }:
{
  plugins.lsp.servers.hls = {
    enable = true;
    # Install per project
    package = null;
    installGhc = false;
  };
}
