# ~~~
# SPDX-FileCopyrightText: Naostage <contact@naostage.com>
# SPDX-FileContributor: Olivier Le Doeuff <olivier.ledoeuff@naostage.com>
# SPDX-License-Identifier: MIT
# ~~~

set(CPM_DOWNLOAD_VERSION "10bf25a8113e2003f259536bc88ad7bc81eff8ff") # v0.35.5
set(CPM_VERSION "v0.35.5")

if(CPM_SOURCE_CACHE)
  # Expand relative path. This is important if the provided path contains a
  # tilde (~)
  get_filename_component(CPM_SOURCE_CACHE ${CPM_SOURCE_CACHE} ABSOLUTE)
  set(CPM_DOWNLOAD_LOCATION
      "${CPM_SOURCE_CACHE}/cpm/CPM_${CPM_DOWNLOAD_VERSION}.cmake")
elseif(DEFINED ENV{CPM_SOURCE_CACHE})
  set(CPM_DOWNLOAD_LOCATION
      "$ENV{CPM_SOURCE_CACHE}/cpm/CPM_${CPM_DOWNLOAD_VERSION}.cmake")
else()
  set(CPM_DOWNLOAD_LOCATION
      "${CMAKE_BINARY_DIR}/cmake/CPM_${CPM_DOWNLOAD_VERSION}.cmake")
endif()

if(NOT (EXISTS ${CPM_DOWNLOAD_LOCATION}))
  message(STATUS "Downloading CPM.cmake to ${CPM_DOWNLOAD_LOCATION}")
  file(
    DOWNLOAD
    https://raw.githubusercontent.com/OlivierLDff/CPM.cmake/${CPM_DOWNLOAD_VERSION}/cmake/CPM.cmake
    ${CPM_DOWNLOAD_LOCATION}
    EXPECTED_HASH MD5=b0aa63cde03b88f5c71079eeb68e9449)
endif()

include(${CPM_DOWNLOAD_LOCATION})
