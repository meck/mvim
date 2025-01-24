{ lib, ... }:
{
  imports = [
    ./options
    ./plugins
    ./mappings
    ./theme
  ];

  config = {
    nixpkgs.overlays = [
      (final: prev: {
        oelint-adv = prev.oelint-adv.overridePythonAttrs (oldAttrs: {
          # Fails on aarch64-darwin
          doCheck = false;
        });
        # TODO wait for https://github.com/c0fec0de/anytree/issues/270
        # TODO wait for https://github.com/NixOS/nixpkgs/issues/375763
        python3Packages = prev.python3Packages.overrideScope (
          _finalPy: prevPy: {
            anytree = prevPy.anytree.overrideAttrs (old: {
              patches = old.patches ++ [ ./python-anytree-poetry-project-name-version.patch ];
            });
          }
        );

      })
    ];
  };

  options = {
    mvim.small = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Build a smaller version not bundling large LSP servers";
    };
  };
}
