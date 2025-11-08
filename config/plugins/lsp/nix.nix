{ pkgs, ... }:
{
  plugins.lsp.servers.nixd = {
    enable = true;
    settings = {
      diagnostic.suppress = [ "sema-escaping-with" ];
      formatting.command = [ "${pkgs.nixfmt-rfc-style}/bin/nixfmt" ];
    };
    # Dosent work with the `# lua` in nixvim
    onAttach.function = # lua
      ''
        client.server_capabilities.semanticTokensProvider = nil
      '';
  };
}
