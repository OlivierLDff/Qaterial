# ~~~
# SPDX-FileCopyrightText: Naostage <contact@naostage.com>
# SPDX-FileContributor: Olivier Le Doeuff <olivier.ledoeuff@naostage.com>
# SPDX-License-Identifier: MIT
# ~~~

if(COMMAND qt_generate_qmldir)
  return()
endif()

include(${CMAKE_CURRENT_LIST_DIR}/CPM.cmake)

CPMAddPackage(
  NAME QtGeneratorCMake
  GIT_REPOSITORY "https://github.com/OlivierLDff/QtGeneratorCMake.git"
  GIT_TAG "162d7e748ea588be4eb1403e5224471a589ae266"
)
