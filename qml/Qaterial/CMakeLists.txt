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

qt_generate_qmldir(QATERIAL_QMLDIR_FILE
 SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}
 MODULE "Qaterial"
)

message(STATUS "Generate Qaterial.qrc")
qt_generate_qrc(QATERIAL_QML_QRC
  SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}
  DEST_DIR ${CMAKE_CURRENT_BINARY_DIR}/Generated
  NAME Qaterial.qrc
  PREFIX "Qaterial"
  GLOB_EXPRESSION "*.qml;qmldir"
  ALWAYS_OVERWRITE
  RECURSE
)

# Add qml to the qtquick compiler (should only be call once per target)
qtquick_compiler_add_resources(QATERIAL_QML_RES ${QATERIAL_QML_QRC})

# Dont Run Moc on cpp file generated from qml
foreach(QATERIAL_CURRENT_QML_FILE ${QATERIAL_QML_RES})
  source_group("Qml\\QtQuickCompiler Files" FILES ${QATERIAL_CURRENT_QML_FILE})
endforeach()

add_library(${QATERIAL_TARGET}Components STATIC ${QATERIAL_QML_RES})
add_library(${QATERIAL_TARGET}::Components ALIAS ${QATERIAL_TARGET}Components)

set_target_properties(${QATERIAL_TARGET}Components PROPERTIES AUTORCC TRUE)
if(QATERIAL_ENABLE_UNITY_BUILD)
  set_target_properties(${QATERIAL_TARGET}Components PROPERTIES UNITY_BUILD ON)
endif()

target_link_libraries(${QATERIAL_TARGET}Components PRIVATE
  Qt::Core
  Qt::Gui
  Qt::Svg
  Qt::Xml
  Qt::Qml
  Qt::Quick
  Qt::QuickControls2
)

if(QATERIAL_FOLDER_PREFIX)
  set_target_properties(${QATERIAL_TARGET}Components PROPERTIES FOLDER ${QATERIAL_FOLDER_PREFIX})
endif()

if(QATERIAL_ENABLE_INSTALL)
  include(GNUInstallDirs)
  install(TARGETS ${QATERIAL_TARGET}Components
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
