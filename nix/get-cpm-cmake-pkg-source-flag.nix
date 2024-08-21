# SPDX-FileCopyrightText: Olivier Le Doeuff <olivier.ldff@gmail.com>
# SPDX-License-Identifier: MIT
let
  getCpmCMakePkgSourceFlag =
    { file
    , cmakeVar
    , cpmPkg
    , private ? false
    , pkgs ? import <nixpkgs> { }
    }:
    let
      pkg = import ./get-pkg-source-from-cmake.nix {
        inherit file cmakeVar pkgs private;
      };
    in
    "-DCPM_${cpmPkg}_SOURCE=${pkg}";
in
getCpmCMakePkgSourceFlag
