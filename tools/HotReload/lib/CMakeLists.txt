set(QATERIAL_HOTRELOAD_LIB QaterialHotReloadLib)
message(STATUS "Add Tool: ${QATERIAL_HOTRELOAD_LIB}")

qtquick_compiler_add_resources(QATERIAL_HOTRELOAD_QML_RES qml/QaterialHotReload.qrc)
configure_file(
  ${CMAKE_CURRENT_SOURCE_DIR}/qml/QaterialHotReload.qrc
  ${CMAKE_CURRENT_BINARY_DIR}/QaterialHotReload.qrc.junk)

add_library(${QATERIAL_HOTRELOAD_LIB} STATIC
  include/Qaterial/HotReload/HotReload.hpp
  src/HotReload.cpp
  ${QATERIAL_HOTRELOAD_QML_RES}
  ${QATERIAL_HOTRELOAD_PLATFORM_SRC})

target_link_libraries(${QATERIAL_HOTRELOAD_LIB} PUBLIC Qaterial)

function(target_link_quiet_libraries TARGET)
  foreach(LIB ${ARGN})
    if(TARGET ${LIB})
      target_link_libraries(${TARGET} PUBLIC ${LIB})
    endif()
  endforeach(LIB)
endfunction()

find_package(Qt5 QUIET COMPONENTS
  Charts
  DataVisualization
  VirtualKeyboard
  WebChannel
  WebSockets
  WebEngine

  3DCore
  3DRender
  3DInput
  3DLogic
  3DExtras
  3DAnimation

  Quick3D
  Quick3DAssetImport
  Quick3DRender
  Quick3DRuntimeRender
  Quick3DUtils)

target_link_quiet_libraries(${QATERIAL_HOTRELOAD_LIB}
  Qt::Charts
  Qt::DataVisualization
  Qt::VirtualKeyboard
  Qt::WebChannel
  Qt::WebSockets
  Qt::WebEngine

  Qt::3DCore
  Qt::3DRender
  Qt::3DInput
  Qt::3DLogic
  Qt::3DExtras
  Qt::3DAnimation

  Qt::Quick3D
  Qt::Quick3DAssetImport
  Qt::Quick3DRender
  Qt::Quick3DRuntimeRender
  Qt::Quick3DUtils)

set_target_properties(${QATERIAL_HOTRELOAD_LIB} PROPERTIES
  FOLDER "${QATERIAL_FOLDER_PREFIX}/HotReload"
  AUTORCC TRUE
  AUTOMOC TRUE)
target_include_directories(${QATERIAL_HOTRELOAD_LIB} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)

if(QATERIAL_ENABLE_PCH AND COMMAND target_precompile_headers)
  target_precompile_headers(${QATERIAL_HOTRELOAD_LIB} PRIVATE ${PROJECT_SOURCE_DIR}/include/Qaterial/Pch/Pch.hpp)
endif()

get_target_property(QT_TARGET_TYPE Qt::Core TYPE)
if(${QT_TARGET_TYPE} STREQUAL "STATIC_LIBRARY")
  qt_generate_qml_plugin_import(${QATERIAL_HOTRELOAD_LIB}
    QML_SRC ${CMAKE_CURRENT_SOURCE_DIR}
    EXTRA_PLUGIN
    QtQuickVirtualKeyboardPlugin
    QtQuickVirtualKeyboardSettingsPlugin
    QtQuickVirtualKeyboardStylesPlugin
    QmlFolderListModelPlugin
    VERBOSE)
  qt_generate_plugin_import(${QATERIAL_HOTRELOAD_LIB} VERBOSE)
endif()