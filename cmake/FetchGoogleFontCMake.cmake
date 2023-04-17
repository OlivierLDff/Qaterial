# ~~~
# SPDX-FileCopyrightText: Naostage <contact@naostage.com>
# SPDX-FileContributor: Olivier Le Doeuff <olivier.ledoeuff@naostage.com>
# SPDX-License-Identifier: MIT
# ~~~

if(COMMAND fetch_google_font)
  return()
endif()

include(${CMAKE_CURRENT_LIST_DIR}/CPM.cmake)

CPMAddPackage(
  NAME FetchGoogleFontCMake
  GIT_REPOSITORY "https://github.com/OlivierLDff/FetchGoogleFontCMake.git"
  GIT_TAG "c19d83a68eda83b9dd3033893dbb63d84c941196"
)
