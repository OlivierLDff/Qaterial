# SPDX-FileCopyrightText: Olivier Le Doeuff <olivier.ldff@gmail.com>
# SPDX-License-Identifier: MIT
{ file, prefix }:
let
  versionFileContent = builtins.readFile file;
  versionMajorParse = builtins.match ".*set\\(${prefix}_VERSION_MAJOR ([0-9]+)\\).*" versionFileContent;
  versionMajor = builtins.elemAt versionMajorParse 0;
  versionMinorParse = builtins.match ".*set\\(${prefix}_VERSION_MINOR ([0-9]+)\\).*" versionFileContent;
  versionMinor = builtins.elemAt versionMinorParse 0;
  versionPatchParse = builtins.match ".*set\\(${prefix}_VERSION_PATCH ([0-9]+)\\).*" versionFileContent;
  versionPatch = builtins.elemAt versionPatchParse 0;
in
"${versionMajor}.${versionMinor}.${versionPatch}"
