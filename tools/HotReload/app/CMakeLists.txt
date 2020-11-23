set(QATERIAL_HOTRELOAD QaterialHotReload)
message(STATUS "Add Tool: ${QATERIAL_HOTRELOAD}")

include(cmake/FetchSortFilterProxyModel.cmake)

qtquick_compiler_add_resources(QATERIAL_HOTRELOAD_APP_QML_RES qml/QaterialHotReloadApp.qrc)
configure_file(
  ${CMAKE_CURRENT_SOURCE_DIR}/qml/QaterialHotReloadApp.qrc
  ${CMAKE_CURRENT_BINARY_DIR}/QaterialHotReloadApp.qrc.junk)

add_executable(${QATERIAL_HOTRELOAD} src/Main.cpp ${QATERIAL_HOTRELOAD_APP_QML_RES})
target_link_libraries(${QATERIAL_HOTRELOAD} PRIVATE QaterialHotReloadLib SortFilterProxyModel)
set_target_properties(${QATERIAL_HOTRELOAD} PROPERTIES
  FOLDER "${QATERIAL_FOLDER_PREFIX}/HotReload")

if(QATERIAL_ENABLE_PCH AND COMMAND target_precompile_headers)
  target_precompile_headers(${QATERIAL_HOTRELOAD} PRIVATE ${PROJECT_SOURCE_DIR}/src/Qaterial/Pch/Pch.hpp)
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
    QML_DIR "${CMAKE_CURRENT_SOURCE_DIR}/qml"
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
