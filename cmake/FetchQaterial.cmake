# ~~~
# SPDX-FileCopyrightText: Naostage <contact@naostage.com>
# SPDX-FileContributor: Olivier Le Doeuff <olivier.ledoeuff@naostage.com>
# SPDX-License-Identifier: MIT
# ~~~

if(TARGET Qaterial::Qaterial)
  return()
endif()

include(${CMAKE_CURRENT_LIST_DIR}/CPM.cmake)

CPMAddPackage(
  NAME QOlm
  GIT_REPOSITORY "https://github.com/OlivierLDff/Qaterial.git"
  GIT_TAG "master"
)
