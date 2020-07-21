set(QATERIAL_HOTRELOAD QaterialHotReload)
message(STATUS "Add Example: ${QATERIAL_HOTRELOAD}")

include(cmake/FetchSortFilterProxyModel.cmake)

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
  Quick3DUtils
)

qtquick_compiler_add_resources(QATERIAL_HOTRELOAD_QML_RES QaterialHotReload.qrc)
configure_file(
  ${CMAKE_CURRENT_SOURCE_DIR}/QaterialHotReload.qrc
  ${CMAKE_CURRENT_BINARY_DIR}/QaterialHotReload.qrc.junk
)

add_executable(${QATERIAL_HOTRELOAD} ${QATERIAL_HOTRELOAD_PLATFORM_TARGET}
  QaterialHotReload.cpp
  ${QATERIAL_HOTRELOAD_QML_RES}
  ${QATERIAL_HOTRELOAD_PLATFORM_SRC}
)

target_link_libraries(${QATERIAL_HOTRELOAD} PRIVATE Qaterial SortFilterProxyModel)
set_target_properties(${QATERIAL_HOTRELOAD} PROPERTIES
  FOLDER "${QATERIAL_FOLDER_PREFIX}/HotReload"
  AUTORCC TRUE
  AUTOMOC TRUE)

if(QATERIAL_ENABLE_PCH AND COMMAND target_precompile_headers)
  target_precompile_headers(${QATERIAL_HOTRELOAD} PRIVATE ../../include/Qaterial/Pch/Pch.hpp)
endif()

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

if(${CMAKE_SYSTEM_NAME} STREQUAL "Windows")
  if(${QT_TARGET_TYPE} STREQUAL "STATIC_LIBRARY")
    set(PLATFORM_NO_DEPLOY NO_DEPLOY)
  endif()

  include(cmake/FetchQtWindowsCMake.cmake)

  add_qt_windows_exe(${QATERIAL_HOTRELOAD}
    ALL
    NAME "Qaterial HotReloader"
    VERSION ${QATERIAL_VERSION}.${QATERIAL_VERSION_TAG_HEX}
    PUBLISHER "Qaterial"
    PRODUCT_URL "https://olivierldff.github.io/Qaterial"
    PACKAGE "com.qaterial.hotreloader"
    ICON "${CMAKE_CURRENT_SOURCE_DIR}/platform/windows/icon.ico"
    ICON_RC "${CMAKE_CURRENT_SOURCE_DIR}/platform/windows/icon.rc"
    QML_DIR ${CMAKE_CURRENT_SOURCE_DIR}
    VERBOSE_LEVEL_DEPLOY 1
    VERBOSE_INSTALLER
    OUTPUT_TARGET QATERIAL_HOTRELOAD_DEPLOY_TARGET
    OUTPUT_INSTALLER_TARGET QATERIAL_HOTRELOAD_INSTALLER_TARGET
    ${PLATFORM_NO_DEPLOY}
  )

  if(QATERIAL_HOTRELOAD_DEPLOY_TARGET)
    set_target_properties(${QATERIAL_HOTRELOAD_DEPLOY_TARGET} PROPERTIES FOLDER "${QATERIAL_FOLDER_PREFIX}/HotReload")
  endif()
  set_target_properties(${QATERIAL_HOTRELOAD_INSTALLER_TARGET} PROPERTIES FOLDER "${QATERIAL_FOLDER_PREFIX}/HotReload")

  file(GLOB QATERIAL_EXAMPLES "../../examples/*.qml")

  foreach(EXAMPLE ${QATERIAL_EXAMPLES})
    add_custom_command(TARGET ${QATERIAL_HOTRELOAD_INSTALLER_TARGET} PRE_BUILD
      COMMAND ${CMAKE_COMMAND} -E make_directory "$<TARGET_FILE_DIR:${QATERIAL_HOTRELOAD}>/examples"
      COMMAND ${CMAKE_COMMAND} -E copy_if_different "${EXAMPLE}" "$<TARGET_FILE_DIR:${QATERIAL_HOTRELOAD}>/examples"
      COMMENT "Deploy ${EXAMPLE} to $<TARGET_FILE_DIR:${QATERIAL_HOTRELOAD}>/examples")
  endforeach()

  if(MSVC)
    set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT ${QATERIAL_HOTRELOAD})
  endif()
endif()

set_target_properties(${QATERIAL_HOTRELOAD}
  PROPERTIES
  ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/$<CONFIG>_Artifact"
  LIBRARY_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/$<CONFIG>_Artifact"
  RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/$<CONFIG>"
)