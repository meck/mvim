{ nixvim, ... }:
{
  imports = [ nixvim.homeManagerModules.nixvim ];
  config = {
    programs.nixvim =
      { lib, ... }:
      let
        standaloneCfg = (import ../config { inherit lib; });
      in
      standaloneCfg
      // {
        config = {
          enable = true;
          viAlias = true;
          # BUG: overlays dont get applied on darwin
          # unless we do this
          inherit (standaloneCfg.config) nixpkgs;
        };
      };
  };
}
