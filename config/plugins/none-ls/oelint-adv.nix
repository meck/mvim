{
  pkgs,
  lib,
  config,
  ...
}:
lib.mkIf (! config.mvim.small)
(with pkgs.python3Packages; let
  oelint-parser = buildPythonPackage rec {
    pname = "oelint-parser";
    version = "3.0.1";
    src = pkgs.fetchFromGitHub {
      owner = "priv-kweihmann";
      repo = "oelint-parser";
      rev = version;
      sha256 = "sha256-+iX4zb6yCFYPos3ui2V3TPtgwn+3RjCTvmr1Zam5PKg=";
    };
    postPatch = ''
      substituteInPlace requirements.txt \
        --replace "regex == 2023.12.25" "regex == 2023.10.3"
    '';
    propagatedBuildInputs = [regex deprecated pip];
  };

  oelint-adv = buildPythonApplication rec {
    pname = "oelint-adv";
    version = "4.0.0";
    src = pkgs.fetchFromGitHub {
      owner = "priv-kweihmann";
      repo = "oelint-adv";
      rev = version;
      sha256 = "sha256-DPcB7Iw3wfhzRCPd74LfszGxRmWEn/1IlUjEqJ20q1w=";
    };
    propagatedBuildInputs = [colorama anytree urllib3 oelint-parser pytest pip];
  };
in {
  extraPackages = [oelint-adv];
})
