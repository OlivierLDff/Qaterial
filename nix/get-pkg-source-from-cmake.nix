# SPDX-FileCopyrightText: Olivier Le Doeuff <olivier.ldff@gmail.com>
# SPDX-License-Identifier: MIT
let
  getPkgSourceFromCMake =
    { file
    , cmakeVar
    , private ? false
    , pkgs ? import <nixpkgs> { }
    }:
    let
      inherit (builtins) elemAt match;
      parse_repo = match ".*set\\(${cmakeVar}_REPOSITORY\n *\"([^\n]*)\"\n.*"
        (builtins.readFile file);
      parse_tag = match ".*set\\(${cmakeVar}_TAG\n *# hash: ([^\n]*)\n *\"([^\n]*)\"\n.*"
        (builtins.readFile file);
      pkg_url = elemAt parse_repo 0;
      pkg_hash = elemAt parse_tag 0;
      pkg_rev = elemAt parse_tag 1;
      parse_url = match ".*github\\.com/([[:alpha:]]+)/([a-zA-Z\\.0-9-]+?)(/.*|$)"
        pkg_url;

      pkg_owner = elemAt parse_url 0;
      pkg_name_with_potential_extensions = elemAt parse_url 1;
      pkg_name = builtins.replaceStrings [ ".git" ".com" ] [ "" "" ] pkg_name_with_potential_extensions;
    in
    pkgs.fetchFromGitHub {
      owner = pkg_owner;
      repo = pkg_name;
      rev = pkg_rev;
      hash = pkg_hash;
      inherit private;
      # Calling github.com/owner/repo/archive/rev.tar.gz doesn't work with PAT...
      # I asked the question here: https://github.com/orgs/community/discussions/121881
      forceFetchGit = private;
    };
in
getPkgSourceFromCMake
