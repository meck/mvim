{
  description = "meck's personal nvim config";

  inputs = {
    nixpkgs.follows = "nixvim/nixpkgs";
    nixvim.url = "github:nix-community/nixvim";
    flake-utils.url = "github:numtide/flake-utils";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixvim/nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixvim,
      flake-utils,
      treefmt-nix,
      ...
    }@inputs:
    {
      # Add `inputs.mvim.homeManagerModules.default` to imports
      # set `programs.nixvim.mvim.small = true;` to use small version
      homeManagerModules.default = import ./modules/home-manager.nix { inherit nixvim inputs; };
    }
    // flake-utils.lib.eachDefaultSystem (
      system:
      let
        nixvimLib = nixvim.lib.${system};

        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        treefmt =
          (treefmt-nix.lib.evalModule pkgs {
            projectRootFile = "flake.nix";
            settings.global.excludes = [
              "README.md"
              "*.vim"
            ];
            programs.nixfmt = {
              enable = true;
              package = pkgs.nixfmt-rfc-style;
            };
            programs.stylua = {
              enable = true;
              settings = {
                indent_width = 4;
                indent_type = "Spaces";
              };
            };
            programs.yamlfmt.enable = true;
          }).config.build;

        nvim = nixvim.legacyPackages.${system}.makeNixvimWithModule {
          inherit pkgs;
          module = import ./config;
          extraSpecialArgs = { };
        };

        nvim-small = nvim.extend { mvim.small = true; };

        mkNvimCheck =
          nvimPkg:
          nixvimLib.check.mkTestDerivationFromNvim {
            nvim = nvimPkg.extend {
              # Tries to get terminal size in tests
              # TODO: https://github.com/nix-community/nixvim/blob/0c867f9e635ce70e829a562b20851cfc17a94196/lib/tests.nix#L18
              plugins.image.enable = pkgs.lib.mkForce false;
            };
            name = "Checks for ${nvimPkg.name}";
          };
      in
      {

        formatter = treefmt.wrapper;

        # `nix run .`
        packages = {
          default = nvim;
          small = nvim-small;
        };

        # `nix flake check .`
        checks = {
          default = mkNvimCheck nvim;
          small = mkNvimCheck nvim-small;
          formatting = treefmt.check self;
        };
      }
    );
}
