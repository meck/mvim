{
  description = "meck's personal nvim config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    nixvim,
    flake-utils,
    ...
  } @ inputs:
    {
      # home-manager module rexeported with custom settings
      # usage: `imports = [ inputs.meckvim.homeManagerModules.default ]`
      homeManagerModules.default = {...}: {
        imports = [nixvim.homeManagerModules.nixvim];
        config = {
          programs.nixvim = pkgs:
            import ./config {inherit pkgs;}
            // {
              enable = true;
              viAlias = true;
            };
        };
      };
    }
    // flake-utils.lib.eachDefaultSystem (system: let
      nixvimLib = nixvim.lib.${system};
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      module = import ./config {inherit pkgs;};
      nvim = nixvim.legacyPackages.${system}.makeNixvimWithModule {
        inherit pkgs module;
      };
    in {
      checks = {
        # `nix flake check .`
        default = nixvimLib.check.mkTestDerivationFromNvim {
          inherit nvim;
          name = "A nixvim configuration";
        };
      };

      # `nix run .`
      packages.default = nvim;
    });
}
