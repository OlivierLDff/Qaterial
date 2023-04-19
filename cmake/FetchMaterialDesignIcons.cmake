# ~~~
# SPDX-FileCopyrightText: Naostage <contact@naostage.com>
# SPDX-FileContributor: Olivier Le Doeuff <olivier.ledoeuff@naostage.com>
# SPDX-License-Identifier: MIT
# ~~~

include(${CMAKE_CURRENT_LIST_DIR}/CPM.cmake)

CPMAddPackage(
  NAME MaterialDesignIcons
  GIT_REPOSITORY "https://github.com/OlivierLDff/MaterialDesignSvgo"
  GIT_TAG "7cc6cc10a0a77d2b23dced9247bd73850f57dc29"
)

set(MATERIALDESIGNICONS_ICONS_DIR "${MaterialDesignIcons_SOURCE_DIR}/svg")
