{
  description = "meck's personal nvim config";

  inputs = {
    nixpkgs.follows = "nixvim/nixpkgs";
    nixvim.url = "github:nix-community/nixvim";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    nixvim,
    flake-utils,
    ...
  } @ inputs:
    {
      # Add `inputs.mvim.homeManagerModules.default` to imports
      # set `programs.nixvim.mvim.small = true;` to use small version
      homeManagerModules.default = import ./modules/home-manager.nix {inherit nixvim;};
    }
    // flake-utils.lib.eachDefaultSystem (system: let
      nixvimLib = nixvim.lib.${system};

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      nvim = nixvim.legacyPackages.${system}.makeNixvimWithModule {
        inherit pkgs;
        module = import ./config;
        extraSpecialArgs = {};
      };

      nvim-small = nvim.nixvimExtend {mvim.small = true;};

      mkNvimCheck = nvimPkg:
        nixvimLib.check.mkTestDerivationFromNvim {
          nvim = nvimPkg;
          name = "Checks for ${nvimPkg.name}";
        };
    in {
      # `nix run .`
      packages = {
        default = nvim;
        small = nvim-small;
      };

      # `nix flake check .`
      checks = {
        default = mkNvimCheck nvim;
        small = mkNvimCheck nvim-small;
      };
    });
}
