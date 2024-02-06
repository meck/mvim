{nixvim, ...}: {
  imports = [nixvim.homeManagerModules.nixvim];
  config = {
    programs.nixvim = {
      pkgs,
      lib,
      ...
    }:
      (import ../config {inherit pkgs lib;})
      // {
        config = {
          enable = true;
          viAlias = true;
        };
      };
  };
}
