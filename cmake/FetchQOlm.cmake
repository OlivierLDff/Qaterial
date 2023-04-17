# ~~~
# SPDX-FileCopyrightText: Naostage <contact@naostage.com>
# SPDX-FileContributor: Olivier Le Doeuff <olivier.ledoeuff@naostage.com>
# SPDX-License-Identifier: MIT
# ~~~

if(TARGET QOlm::QOlm)
  return()
endif()

include(${CMAKE_CURRENT_LIST_DIR}/CPM.cmake)

CPMAddPackage(
  NAME QOlm
  GIT_REPOSITORY "https://github.com/OlivierLDff/QOlm.git"
  GIT_TAG "v3.2.0"
  OPTIONS "QOLM_ENABLE_INSTALL ${QATERIAL_ENABLE_INSTALL}" "QOLM_FOLDER_PREFIX Dependencies"
)
