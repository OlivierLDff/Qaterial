# ~~~
# SPDX-FileCopyrightText: Naostage <contact@naostage.com>
# SPDX-FileContributor: Olivier Le Doeuff <olivier.ledoeuff@naostage.com>
# SPDX-License-Identifier: MIT
# ~~~

if(COMMAND qt_generate_plugin_import)
  return()
endif()

include(${CMAKE_CURRENT_LIST_DIR}/CPM.cmake)

CPMAddPackage(
  NAME QtStaticCMake
  GIT_REPOSITORY "https://github.com/OlivierLDff/QtStaticCMake.git"
  GIT_TAG "5b4bb893934bd5cdeb39a52a46b4c05536603f95"
)
