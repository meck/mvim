{
  description = "meck's personal nvim config";

  inputs = {
    nixpkgs.follows = "nixvim/nixpkgs";
    nixvim.url = "github:nix-community/nixvim";
    flake-utils.url = "github:numtide/flake-utils";
    nix-appimage = {
      url = "github:ralismark/nix-appimage";
      inputs.nixpkgs.follows = "nixvim/nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = {
    nixpkgs,
    nixvim,
    flake-utils,
    nix-appimage,
    ...
  }:
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

      # Bundle all inputs into an AppImage
      mkAppImage = p:
        nix-appimage.mkappimage.${system} {
          drv = p;
          entrypoint = pkgs.lib.getExe p;
          inherit (p) name;
        };

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
        appimage = mkAppImage nvim-small;
      };

      # `nix flake check .`
      checks = {
        default = mkNvimCheck nvim;
        small = mkNvimCheck nvim-small;
      };
    });
}
