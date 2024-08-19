# SPDX-FileCopyrightText: Naostage <contact@naostage.com>
# SPDX-License-Identifier: UNLICENSED
{
  description = "qaterial";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
    nix-gl-host = {
      url = "github:numtide/nix-gl-host";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    , nix-gl-host
    }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
      };

      qt = pkgs.qt6;
      nixglhost = nix-gl-host.packages.${system}.default;

      nativeBuildInputs = with pkgs; [
        qt.wrapQtAppsHook
        makeWrapper
        gcc
        git
        cmake
        cpm-cmake
        ninja
        gtest
      ];

      buildInputs = with pkgs.qt6; [
        qtbase
        qtsvg
        qtdeclarative
        qt5compat
      ];

      nativeCheckInputs = with pkgs; [
        dbus
        xvfb-run
      ];

      shellHook = ''
        # Crazy shell hook to set up Qt environment, from:
        # https://discourse.nixos.org/t/python-qt-woes/11808/12
        setQtEnvironment=$(mktemp --suffix .setQtEnvironment.sh)
        echo "shellHook: setQtEnvironment = $setQtEnvironment"
        makeWrapper "/bin/sh" "$setQtEnvironment" "''${qtWrapperArgs[@]}"
        sed "/^exec/d" -i "$setQtEnvironment"
        source "$setQtEnvironment"
      '';

      devShellHook = pkgs.lib.concatStringsSep "\n" (
        [ shellHook ]
      );

      CPM_USE_LOCAL_PACKAGES = "ON";

      packages = {
        default = null;
        deadnix = pkgs.runCommand "deadnix" { } ''
          ${pkgs.deadnix}/bin/deadnix --fail ${./.}
          mkdir $out
        '';
      };

      apps = {
        default = null;
      };

      minimalDevBuildInputs = with pkgs; [
        gh
      ];
      fullDevBuildInputs = with pkgs; nativeBuildInputs
        ++ nativeCheckInputs
        ++ minimalDevBuildInputs
        ++ [
        sccache
        nixpkgs-fmt
        cmake-format
        clang-tools
        lazygit
        neovim
        nixglhost
      ]
        ++ pkgs.lib.lists.optionals (stdenv.isLinux) [
        gdb
      ];

    in
    {
      inherit packages apps;

      devShells = {
        minimal = pkgs.mkShell {
          name = "qaterial-minimal-shell";

          inherit buildInputs shellHook;
          inherit CPM_USE_LOCAL_PACKAGES;

          nativeBuildInputs = nativeBuildInputs
            ++ nativeCheckInputs
            ++ minimalDevBuildInputs;
        };

        default = pkgs.mkShell {
          name = "qaterial-dev-shell";

          inherit buildInputs;
          inherit CPM_USE_LOCAL_PACKAGES;

          shellHook = devShellHook;
          nativeBuildInputs = fullDevBuildInputs;
        };
      };

      formatter = pkgs.nixpkgs-fmt;
      checks = {
        inherit (self.packages.${system}) deadnix;
      };
    });
}
