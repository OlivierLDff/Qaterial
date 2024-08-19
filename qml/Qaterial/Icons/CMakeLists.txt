# MIT License
#
# Copyright (c) 2020 Olivier Le Doeuff
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# No matter if QATERIAL_ENABLE_ICONS is ON or OFF, always generate something.
# From Qaterial point of view nothing change

if(QATERIAL_ENABLE_ICONS)

  # Download svgs icons
  include(${PROJECT_SOURCE_DIR}/cmake/FetchMaterialDesignIcons.cmake)

  file(GLOB_RECURSE QATERIAL_ICONS_FILES
    LIST_DIRECTORIES false
    ${MATERIALDESIGNICONS_ICONS_DIR}/${QATERIAL_ICONS}
  )

  foreach(QATERIAL_ICON_FILE ${QATERIAL_ICONS_FILES})
    get_filename_component(QATERIAL_ICON_FILE_NAME ${QATERIAL_ICON_FILE} NAME)
    set_source_files_properties(${QATERIAL_ICON_FILE} PROPERTIES
      QT_RESOURCE_ALIAS ${QATERIAL_ICON_FILE_NAME}
    )
  endforeach()
endif()

qt_add_library(${QATERIAL_TARGET}Icons STATIC)

if(QATERIAL_ENABLE_ICONS)
  qt_add_qml_module(${QATERIAL_TARGET}Icons
    URI "Qaterial.Icons"
    RESOURCE_PREFIX "/"
    RESOURCES
      ${QATERIAL_ICONS_FILES}
    OUTPUT_TARGETS QATERIAL_ICONS_QML_TARGETS
    NO_PLUGIN
  )
endif()

add_library(${QATERIAL_TARGET}::Icons ALIAS ${QATERIAL_TARGET}Icons)

target_link_libraries(${QATERIAL_TARGET}Icons PRIVATE
  Qt::Core
  Qt::Gui
  Qt::Svg
  Qt::Xml
  Qt::Qml
)

if(QATERIAL_FOLDER_PREFIX)
  set_target_properties(${QATERIAL_TARGET}Icons PROPERTIES FOLDER ${QATERIAL_FOLDER_PREFIX})
endif()

if(QATERIAL_ENABLE_INSTALL)
include(GNUInstallDirs)
  install(TARGETS ${QATERIAL_TARGET}Icons ${QATERIAL_ICONS_QML_TARGETS}
    EXPORT ${QATERIAL_TARGET}IconsTargets
  )

  export(EXPORT ${QATERIAL_TARGET}IconsTargets
    FILE "${CMAKE_CURRENT_BINARY_DIR}/${QATERIAL_TARGET}/${QATERIAL_TARGET}IconsTargets.cmake"
  )

  set(ConfigPackageLocation lib/cmake/${QATERIAL_TARGET})
  install(EXPORT ${QATERIAL_TARGET}IconsTargets
    FILE
    ${QATERIAL_TARGET}IconsTargets.cmake
    DESTINATION
    ${ConfigPackageLocation}
  )
endif()
