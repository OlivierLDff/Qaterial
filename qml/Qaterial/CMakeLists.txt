# Copyright 2019-2020 Olivier Le Doeuff
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation
# files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy,
# modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software
# is furnished to do so, subject to the following conditions:
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
# DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
# OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

file(GLOB_RECURSE QATERIAL_QML_FILES
  RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
  LIST_DIRECTORIES false
  "*.qml"
)

set(SINGLETON_FILES
  ${CMAKE_CURRENT_SOURCE_DIR}/Style.qml
  ${CMAKE_CURRENT_SOURCE_DIR}/Colors.qml
  ${CMAKE_CURRENT_SOURCE_DIR}/DataFormat.qml
  ${CMAKE_CURRENT_SOURCE_DIR}/DialogManager.qml
  ${CMAKE_CURRENT_SOURCE_DIR}/SnackbarManager.qml
  ${CMAKE_CURRENT_SOURCE_DIR}/Style.qml
)

set_source_files_properties(${SINGLETON_FILES} PROPERTIES QT_QML_SINGLETON_TYPE TRUE)

qt_add_library(${QATERIAL_TARGET}Components STATIC)
qt_add_qml_module(${QATERIAL_TARGET}Components
  URI Qaterial
  VERSION 1.0
  RESOURCE_PREFIX "/"
  QML_FILES
    ${QATERIAL_QML_FILES}
  OUTPUT_TARGETS QATERIAL_COMPONENTS_QML_TARGETS
  NO_PLUGIN
)
add_library(${QATERIAL_TARGET}::Components ALIAS ${QATERIAL_TARGET}Components)

set_target_properties(${QATERIAL_TARGET}Components PROPERTIES AUTORCC TRUE)

target_link_libraries(${QATERIAL_TARGET}Components PRIVATE
  Qt::Core
  Qt::Gui
  Qt::Svg
  Qt::Xml
  Qt::Qml
  Qt::Quick
  Qt::QuickControls2
  Qt::Core5Compat
)

if(QATERIAL_FOLDER_PREFIX)
  set_target_properties(${QATERIAL_TARGET}Components PROPERTIES FOLDER ${QATERIAL_FOLDER_PREFIX})
endif()

if(QATERIAL_ENABLE_INSTALL AND NOT QATERIAL_BUILD_SHARED)
  include(GNUInstallDirs)
  install(TARGETS ${QATERIAL_TARGET}Components ${QATERIAL_COMPONENTS_QML_TARGETS}
    EXPORT ${QATERIAL_TARGET}ComponentsTargets
  )

  export(EXPORT ${QATERIAL_TARGET}ComponentsTargets
    FILE "${CMAKE_CURRENT_BINARY_DIR}/${QATERIAL_TARGET}/${QATERIAL_TARGET}ComponentsTargets.cmake"
  )

  set(ConfigPackageLocation lib/cmake/${QATERIAL_TARGET})
  install(EXPORT ${QATERIAL_TARGET}ComponentsTargets
    FILE
    ${QATERIAL_TARGET}ComponentsTargets.cmake
    DESTINATION
    ${ConfigPackageLocation}
  )
endif()
