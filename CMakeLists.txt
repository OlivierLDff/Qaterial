#
#   Qaterial CMake script by Olivier Le Doeuff
#

cmake_minimum_required(VERSION 3.14.0 FATAL_ERROR)

# ───── PROJECT OPTIONS ─────

include(cmake/Version.cmake)

set(QATERIAL_PROJECT "Qaterial" CACHE STRING "Project Name")
set(QATERIAL_TARGET ${QATERIAL_PROJECT} CACHE STRING "Target Name")
set(QATERIAL_FOLDER_PREFIX ${QATERIAL_PROJECT} CACHE STRING "Prefix folder for all Qaterial generated targets in generated project (only decorative)")
set(QATERIAL_BUILD_SHARED OFF CACHE BOOL "Build as a shared library")
set(QATERIAL_ENABLE_HOTRELOAD OFF CACHE BOOL "Build Qaterial HotReload executable")
if(QATERIAL_ENABLE_HOTRELOAD)
  set(QATERIAL_ENABLE_HOTRELOAD_LIB ${QATERIAL_ENABLE_HOTRELOAD} CACHE BOOL "Build Qaterial HotReload executable" FORCE)
else()
  set(QATERIAL_ENABLE_HOTRELOAD_LIB ${QATERIAL_ENABLE_HOTRELOAD} CACHE BOOL "Build Qaterial HotReload executable")
endif()
set(QATERIAL_ENABLE_HELLOWORLD OFF CACHE BOOL "Build Qaterial HelloWorld executable")
set(QATERIAL_ENABLE_TESTS OFF CACHE BOOL "Build Qaterial test executable")
set(QATERIAL_ENABLE_PCH ON CACHE BOOL
 "Enable precompile headers support for 'Qaterial'. \"
 Only work if CMake support 'target_precompile_headers'. \"
 This can speed up compilation time.")

set(QATERIAL_ENABLE_ICONS ON CACHE BOOL "Embed Mdi Icons in Qaterial.Icons (MATERIALDESIGNICONS_REPOSITORY)")
set(QATERIAL_ICONS "*.svg" CACHE STRING "Filter embedded icons")

set(QATERIAL_ENABLE_ROBOTO ON CACHE BOOL "Embed to qrc Roboto Regular & Medium")
set(QATERIAL_ENABLE_ROBOTOMONO ON CACHE BOOL "Embed to qrc RobotoMono Regular")
set(QATERIAL_ENABLE_LATO ON CACHE BOOL "Embed to qrc Lato Regular")

project(${QATERIAL_PROJECT} VERSION ${QATERIAL_VERSION} LANGUAGES CXX)
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

message(STATUS "------ ${QATERIAL_TARGET} Configuration ------")

message(STATUS "QATERIAL_PROJECT                : ${QATERIAL_PROJECT}")
message(STATUS "QATERIAL_TARGET                 : ${QATERIAL_TARGET}")
message(STATUS "QATERIAL_VERSION                : ${QATERIAL_VERSION}")
message(STATUS "QATERIAL_VERSION_TAG_HEX        : ${QATERIAL_VERSION_TAG_HEX}")
message(STATUS "QATERIAL_BUILD_SHARED           : ${QATERIAL_BUILD_SHARED}")
message(STATUS "QATERIAL_FOLDER_PREFIX          : ${QATERIAL_FOLDER_PREFIX}")

message(STATUS "QATERIAL_ENABLE_ICONS           : ${QATERIAL_ENABLE_ICONS}")
message(STATUS "QATERIAL_ICONS                  : ${QATERIAL_ICONS}")

message(STATUS "QATERIAL_ENABLE_ROBOTO          : ${QATERIAL_ENABLE_ROBOTO}")
message(STATUS "QATERIAL_ENABLE_ROBOTOMONO      : ${QATERIAL_ENABLE_ROBOTOMONO}")
message(STATUS "QATERIAL_ENABLE_LATO            : ${QATERIAL_ENABLE_LATO}")

message(STATUS "QATERIAL_ENABLE_HOTRELOAD       : ${QATERIAL_ENABLE_HOTRELOAD}")
message(STATUS "QATERIAL_ENABLE_HOTRELOAD_LIB   : ${QATERIAL_ENABLE_HOTRELOAD_LIB}")
message(STATUS "QATERIAL_ENABLE_HELLOWORLD      : ${QATERIAL_ENABLE_HELLOWORLD}")
message(STATUS "QATERIAL_ENABLE_TESTS           : ${QATERIAL_ENABLE_TESTS}")

message(STATUS "------ ${QATERIAL_TARGET} End Configuration ------")

# ───── QT DEPENDENCIES ─────

find_package(Qt5 REQUIRED COMPONENTS
  Core
  Gui
  Qml
  Quick
  QuickControls2
  Svg
  Xml
  QuickCompiler
)
find_package(Qt5 QUIET COMPONENTS QmlWorkerScript)

# ───── FETCH DEPEDENCIES ─────

include(cmake/Dependencies.cmake)
include(cmake/FetchSpdlog.cmake)
include(cmake/FetchQOlm.cmake)
include(cmake/FetchQtGeneratorCMake.cmake)

# ───── RESSOURCES ─────

add_subdirectory(res)

# ───── QML SOURCES ─────

file(GLOB_RECURSE QATERIAL_QML_SRCS qml/*.qml)

foreach(SOURCE IN ITEMS ${QATERIAL_QML_SRCS})
  get_filename_component(SOURCE_PATH "${SOURCE}" PATH)
  file(RELATIVE_PATH SOURCE_PATH_REL ${CMAKE_CURRENT_SOURCE_DIR}/qml "${SOURCE_PATH}")
  string(REPLACE "/" "\\" GROUP_PATH "${SOURCE_PATH_REL}")
  source_group("Qml\\${GROUP_PATH}" FILES "${SOURCE}")
endforeach()

qt_generate_qmldir(QATERIAL_QMLDIR_FILE
 SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/qml/Qaterial
 MODULE "Qaterial")

qt_generate_qrc(QATERIAL_QML_QRC
  SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/qml/Qaterial
  DEST_DIR ${CMAKE_CURRENT_BINARY_DIR}/QaterialGenerated
  NAME Qaterial.qrc
  PREFIX "Qaterial"
  GLOB_EXPRESSION "*.qml;qmldir"
  RECURSE)

# Add qml to the qtquick compiler (should only be call once per target)
qtquick_compiler_add_resources(QATERIAL_QML_RES ${QATERIAL_QML_QRC})

# Dont Run Moc on cpp file generated from qml
foreach(QATERIAL_CURRENT_QML_FILE ${QATERIAL_QML_RES})
  set_property(SOURCE ${QATERIAL_CURRENT_QML_FILE} PROPERTY SKIP_AUTOMOC ON)
  source_group("Qml\\QtQuickCompiler Files" FILES ${QATERIAL_CURRENT_QML_FILE})
endforeach()

set(QATERIAL_LAYOUT_SRCS
  include/Qaterial/Layout.hpp
  src/Layout.cpp
)

set(QATERIAL_IO_SRCS
  include/Qaterial/TextFile.hpp
  src/TextFile.cpp
  include/Qaterial/Clipboard.hpp
  src/Clipboard.cpp
  include/Qaterial/FolderTreeModel.hpp
  src/FolderTreeModel.cpp
)

set(QATERIAL_NAVIGATION_SRCS
  include/Qaterial/StepperElement.hpp
  src/StepperElement.cpp
  include/Qaterial/TreeElement.hpp
  src/TreeElement.cpp
)

set(QATERIAL_UTILS_SRCS
  include/Qaterial/Qaterial.hpp
  include/Qaterial/Export.hpp
  include/Qaterial/Property.hpp
  include/Qaterial/Version.hpp
  src/Version.cpp
  include/Qaterial/Utils.hpp
  src/Utils.cpp
  include/Qaterial/Logger.hpp
  src/Logger.cpp
)

set(QATERIAL_SRCS
  ${QATERIAL_LAYOUT_SRCS}
  ${QATERIAL_IO_SRCS}
  ${QATERIAL_NAVIGATION_SRCS}
  ${QATERIAL_UTILS_SRCS}
  ${QATERIAL_QML_RES}
  ${QATERIAL_QML_SRCS}
)

source_group("Layout" FILES ${QATERIAL_LAYOUT_SRCS})
source_group("IO" FILES ${QATERIAL_IO_SRCS})
source_group("Navigation" FILES ${QATERIAL_NAVIGATION_SRCS})
source_group("Utils" FILES ${QATERIAL_UTILS_SRCS})

# ───── QATERIAL TARGET ─────

if(${QATERIAL_BUILD_SHARED})
  add_library(${QATERIAL_TARGET} SHARED ${QATERIAL_SRCS})
  target_compile_definitions(${QATERIAL_TARGET} PUBLIC -DQATERIAL_SHARED)
else()
  add_library(${QATERIAL_TARGET} STATIC ${QATERIAL_SRCS})
  target_compile_definitions(${QATERIAL_TARGET} PUBLIC -DQATERIAL_STATIC)
endif()

target_compile_features(${QATERIAL_TARGET} PUBLIC cxx_std_17)
target_include_directories(${QATERIAL_TARGET} PUBLIC include)
if(QATERIAL_ENABLE_PCH AND COMMAND target_precompile_headers)
  target_precompile_headers(${QATERIAL_TARGET} PRIVATE include/Qaterial/Pch/Pch.hpp)
endif()

target_link_libraries(${QATERIAL_TARGET} PRIVATE
  ${QATERIAL_TARGET}Icons
  ${QATERIAL_TARGET}Fonts
)

target_link_libraries(${QATERIAL_TARGET} PUBLIC
  spdlog
  QOlm
  Qt::Core
  Qt::Gui
  Qt::Svg
  Qt::Xml
  Qt::Qml
  Qt::Quick
  Qt::QuickControls2
)

set_target_properties(${QATERIAL_TARGET} PROPERTIES AUTORCC TRUE)
set_target_properties(${QATERIAL_TARGET} PROPERTIES AUTOMOC TRUE)

# Version
target_compile_definitions(${QATERIAL_TARGET}
  PRIVATE -DQATERIAL_VERSION_MAJOR=${QATERIAL_VERSION_MAJOR}
  PRIVATE -DQATERIAL_VERSION_MINOR=${QATERIAL_VERSION_MINOR}
  PRIVATE -DQATERIAL_VERSION_PATCH=${QATERIAL_VERSION_PATCH}
  PRIVATE -DQATERIAL_VERSION_TAG=${QATERIAL_VERSION_TAG}
  PRIVATE -DQATERIAL_VERSION_TAG_HEX=${QATERIAL_VERSION_TAG_HEX}
)

if(QATERIAL_FOLDER_PREFIX)
  set_target_properties(${QATERIAL_TARGET} PROPERTIES FOLDER ${QATERIAL_FOLDER_PREFIX})
endif()

# Correctly link to static qt
get_target_property(QT_TARGET_TYPE Qt5::Core TYPE)
if(${QT_TARGET_TYPE} STREQUAL "STATIC_LIBRARY")
  include(cmake/FetchQtStaticCMake.cmake)
  qt_generate_qml_plugin_import(${QATERIAL_TARGET}
    QML_SRC qml
    EXTRA_PLUGIN
      QtQuickVirtualKeyboardPlugin
      QtQuickVirtualKeyboardSettingsPlugin
      QtQuickVirtualKeyboardStylesPlugin
      QmlFolderListModelPlugin
    VERBOSE
  )
  qt_generate_plugin_import(${QATERIAL_TARGET} VERBOSE)
endif()

if(TARGET Qt5::QmlWorkerScript)
  target_link_libraries(${QATERIAL_TARGET} PUBLIC Qt5::QmlWorkerScript)
endif()

# ───── QATERIAL TOOLS ─────

add_subdirectory(tools)

# ───── QATERIAL TESTS ─────

if(QATERIAL_ENABLE_TESTS)
  enable_testing()
  add_subdirectory(tests)
endif()
