{ ... }:
{
  plugins.rustaceanvim = {
    enable = true;
    settings = {
      server.default_settings.rust-analyzer = {
        cargo = {
          allTargets = true;
          features = "all";
        };
        check = {
          command = "clippy";
          extraArgs = [ "--no-deps" ];
        };
      };
    };
  };
}
