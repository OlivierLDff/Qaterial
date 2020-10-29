set(QATERIAL_HELLOWORLD QaterialHelloWorld)
message(STATUS "Add Example: ${QATERIAL_HELLOWORLD}")

# Precompile ressources
qtquick_compiler_add_resources(QATERIAL_HELLOWORLD_QML_RES HelloWorld.qrc)

# Trick to force cmake to run each time qrc is modified
configure_file(
  ${CMAKE_CURRENT_SOURCE_DIR}/HelloWorld.qrc
  ${CMAKE_CURRENT_BINARY_DIR}/HelloWorld.qrc.junk
)

# Create our app
add_executable(${QATERIAL_HELLOWORLD}
  HelloWorld.cpp
  ${QATERIAL_HELLOWORLD_QML_RES}
)

# We assume that Qaterial is available somewhere. You should have a look at 'cmake/FetchQaterial.cmake'
target_link_libraries(${QATERIAL_HELLOWORLD} PRIVATE Qaterial)

# AUTOMOC isn't necessary here, but it's a hello world
# AUTORCC is to compile the .qrc files
set_target_properties(${QATERIAL_HELLOWORLD} PROPERTIES
  FOLDER "${QATERIAL_FOLDER_PREFIX}/HelloWorld"
  AUTORCC TRUE
  AUTOMOC TRUE)

# Fix gcc7 bug major/minor
if(QATERIAL_ENABLE_PCH AND COMMAND target_precompile_headers)
  target_precompile_headers(${QATERIAL_HELLOWORLD} PRIVATE ${PROJECT_SOURCE_DIR}/include/Qaterial/Pch/Pch.hpp)
endif()

# Support Static Qt (this will be no longer necessary with qt6)
get_target_property(QT_TARGET_TYPE Qt::Core TYPE)
if(${QT_TARGET_TYPE} STREQUAL "STATIC_LIBRARY")
  qt_generate_qml_plugin_import(${QATERIAL_HELLOWORLD}
    QML_SRC ${CMAKE_CURRENT_SOURCE_DIR}
    EXTRA_PLUGIN
      QtQuickVirtualKeyboardPlugin
      QtQuickVirtualKeyboardSettingsPlugin
      QtQuickVirtualKeyboardStylesPlugin
      QmlFolderListModelPlugin
    VERBOSE
    )
  qt_generate_plugin_import(${QATERIAL_HELLOWORLD} VERBOSE)
endif()