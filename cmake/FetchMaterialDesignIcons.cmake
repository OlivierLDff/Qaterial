# ~~~
# SPDX-FileCopyrightText: Naostage <contact@naostage.com>
# SPDX-FileContributor: Olivier Le Doeuff <olivier.ledoeuff@naostage.com>
# SPDX-License-Identifier: MIT
# ~~~

include(${CMAKE_CURRENT_LIST_DIR}/CPM.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/Dependencies.cmake)

CPMAddPackage(
  NAME MaterialDesignIcons
  GIT_REPOSITORY ${MDI_REPOSITORY}
  GIT_TAG ${MDI_TAG}
)

set(MATERIALDESIGNICONS_ICONS_DIR "${MaterialDesignIcons_SOURCE_DIR}/svg")
