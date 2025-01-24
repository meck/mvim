{ nixvim, inputs, ... }:
{
  imports = [ nixvim.homeManagerModules.nixvim ];
  config.programs.nixvim =
    { lib, ... }:
    let
      standaloneCfg = (import ../config { inherit lib; });
    in
    lib.attrsets.recursiveUpdate standaloneCfg {
      config = {
        enable = true;
        viAlias = true;
        nixpkgs.source = inputs.nixpkgs;
      };
    };
}
