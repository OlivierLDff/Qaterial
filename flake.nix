# SPDX-FileCopyrightText: Olivier Le Doeuff<olivier.ldff@gmail.com>
# SPDX-License-Identifier: MIT
{
  description = "qaterial";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
    nix-filter.url = "github:numtide/nix-filter";
    nix-gl-host = {
      url = "github:numtide/nix-gl-host";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    qolm = {
      url = "github:olivierldff/qolm/v3.2.2";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
      inputs.nix-filter.follows = "nix-filter";
    };
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    , nix-filter
    , nix-gl-host
    , qolm
    }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (_: _: {
            inherit (qolm.packages.${system}) qolm;
          })
        ];
      };

      nixglhost = nix-gl-host.packages.${system}.default;

      nativeBuildInputs = with pkgs; [
        qt6.wrapQtAppsHook
        makeWrapper
        gcc
        git
        cmake
        cpm-cmake
        ninja
        gtest
      ];

      buildInputsFontRoboto = [ pkgs.roboto ];
      buildInputsFontRobotoMono = [ pkgs.roboto-mono ];
      buildInputsFontLato = [ pkgs.lato ];

      buildInputs = with pkgs.qt6; [
        qtbase
        qtsvg
        qtdeclarative
        qt5compat
      ] ++ [
        pkgs.qolm
      ] ++ buildInputsFontRoboto
      ++ buildInputsFontRobotoMono
      ++ buildInputsFontLato;

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

      version = import ./nix/get-project-version.nix { file = ./cmake/Version.cmake; prefix = "QATERIAL"; };
      CPM_USE_LOCAL_PACKAGES = "ON";
      getCpmCMakePkgSourceFlag = { cmakeVar, cpmPkg, private ? false }: import ./nix/get-cpm-cmake-pkg-source-flag.nix
        {
          file = ./cmake/Dependencies.cmake;
          inherit cmakeVar cpmPkg private pkgs;
        };

      cpmCMakeFlags = [
        (getCpmCMakePkgSourceFlag { cmakeVar = "MDI"; cpmPkg = "MaterialDesignIcons"; })
      ];

      fontDirs = builtins.concatStringsSep ":" [
        "${pkgs.roboto}/share/fonts/truetype"
        "${pkgs.roboto-mono}/share/fonts/truetype"
        "${pkgs.lato}/share/fonts/lato"
      ];

      qaterial = with pkgs; stdenv.mkDerivation rec {
        inherit version nativeBuildInputs buildInputs nativeCheckInputs;
        inherit CPM_USE_LOCAL_PACKAGES;

        pname = "qaterial";
        src = nix-filter {
          root = ./.;
          include = [
            "cmake"
            "examples"
            "src"
            "qml"
            "tests"
            ./CMakeLists.txt
          ];
        };

        cmakeFlags = [
          (pkgs.lib.strings.cmakeBool "BUILD_SHARED_LIBS" true)
          (pkgs.lib.strings.cmakeBool "QATERIAL_ENABLE_TESTS" doCheck)
          (pkgs.lib.strings.cmakeBool "QATERIAL_ENABLE_EXAMPLES" doCheck)
          (pkgs.lib.strings.cmakeBool "QATERIAL_USE_LOCAL_CPM_FILE" true)
          (pkgs.lib.strings.cmakeBool "QATERIAL_ENABLE_UNITY_BUILD" false)
          (pkgs.lib.strings.cmakeBool "QATERIAL_ENABLE_INSTALL" true)
          # Disable fonts, as they are available in the system
          (pkgs.lib.strings.cmakeBool "QATERIAL_ENABLE_ROBOTO" false)
          (pkgs.lib.strings.cmakeBool "QATERIAL_ENABLE_ROBOTOMONO" false)
          (pkgs.lib.strings.cmakeBool "QATERIAL_ENABLE_LATO" false)
          # Load fonts from the system
          (pkgs.lib.strings.cmakeFeature "QATERIAL_FONTS_DIRS" fontDirs)
        ] ++ cpmCMakeFlags;

        cmakeConfigType = "Release";
        enableParallelBuilding = true;
        # Enable debug output folder to exists and be kept
        separateDebugInfo = true;

        out = [ "out" ];


        buildPhase = ''
          echo "Building qolm version ${version} in ${cmakeConfigType} mode"

          cmake --build . --config ${cmakeConfigType} --target \
            Qaterial \
            --parallel $NIX_BUILD_CORES
        '';

        doCheck = pkgs.stdenv.hostPlatform == pkgs.stdenv.buildPlatform;
        checkPhase = pkgs.lib.optionalString doCheck ''
          cmake --build . --config ${cmakeConfigType} --target \
            QaterialTestLoader \
            --parallel $NIX_BUILD_CORES

          echo "Run shell hook"
          ${shellHook}

          xvfb-run dbus-run-session \
            --config-file=${pkgs.dbus}/share/dbus-1/session.conf \
            ctest -C "${cmakeConfigType}" --output-on-failure --verbose
        '';

        installPhase = ''
          cmake --install . --config ${cmakeConfigType} --prefix $out
        '';

        doInstallCheck = doCheck;
        installCheckPhase = pkgs.lib.optionalString doInstallCheck ''
          echo "test that cmake package is found"
          cmake -E make_directory find_package_build
          cmake \
            -DCMAKE_BUILD_TYPE="${cmakeConfigType}" \
            -DCMAKE_INSTALL_PREFIX=$out \
            -B find_package_build \
            -S ../tests/FindPackageTest
          cmake \
            --build find_package_build \
            --target "QaterialFindPackageTest" \
            --config "${cmakeConfigType}" \
            --parallel $NIX_BUILD_CORES

          echo "Run shell hook"
          ${shellHook}

          xvfb-run dbus-run-session \
            --config-file=${pkgs.dbus}/share/dbus-1/session.conf \
            find_package_build/QaterialFindPackageTest
        '';
      };

      packages = {
        inherit qaterial;
        default = qaterial;
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
