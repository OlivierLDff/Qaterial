set(QATERIAL_HOTRELOAD QaterialHotReload)
message(STATUS "Add Example: ${QATERIAL_HOTRELOAD}")

qtquick_compiler_add_resources(QATERIAL_HOTRELOAD_QML_RES QaterialHotReload.qrc)
configure_file(
  ${CMAKE_CURRENT_SOURCE_DIR}/QaterialHotReload.qrc
  ${CMAKE_CURRENT_BINARY_DIR}/QaterialHotReload.qrc.junk
)

add_executable(${QATERIAL_HOTRELOAD} QaterialHotReload.cpp ${QATERIAL_HOTRELOAD_QML_RES})
target_link_libraries(${QATERIAL_HOTRELOAD} PRIVATE Qaterial)
set_target_properties(${QATERIAL_HOTRELOAD} PROPERTIES
  FOLDER "${QATERIAL_FOLDER_PREFIX}/HotReload"
  AUTORCC TRUE
  AUTOMOC TRUE)

get_target_property(QT_TARGET_TYPE Qt5::Core TYPE)
if(${QT_TARGET_TYPE} STREQUAL "STATIC_LIBRARY")
  qt_generate_qml_plugin_import(${QATERIAL_HOTRELOAD}
    QML_SRC ${CMAKE_CURRENT_SOURCE_DIR}
    EXTRA_PLUGIN
      QtQuickVirtualKeyboardPlugin
      QtQuickVirtualKeyboardSettingsPlugin
      QtQuickVirtualKeyboardStylesPlugin
      QmlFolderListModelPlugin
    VERBOSE
    )
  qt_generate_plugin_import(${QATERIAL_HOTRELOAD} VERBOSE)
endif()