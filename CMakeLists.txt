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

cmake_minimum_required(VERSION 3.14.0 FATAL_ERROR)

# ───── PROJECT OPTIONS ─────

include(cmake/Version.cmake)

set(QATERIAL_PROJECT "Qaterial" CACHE STRING "Project Name")
set(QATERIAL_TARGET ${QATERIAL_PROJECT} CACHE STRING "Target Name")
set(QATERIAL_FOLDER_PREFIX ${QATERIAL_PROJECT} CACHE STRING "Prefix folder for all Qaterial generated targets in generated project (only decorative)")
set(QATERIAL_BUILD_SHARED OFF CACHE BOOL "Build as a shared library")
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

# ───── FETCH DEPEDENCIES ─────

include(cmake/Dependencies.cmake)
include(cmake/FetchSpdlog.cmake)
include(cmake/FetchQOlm.cmake)
include(cmake/FetchQtGeneratorCMake.cmake)

# ───── RESSOURCES ─────

add_subdirectory(qml)
include(cmake/QaterialGenerateIcons.cmake)
set(QATERIAL_ICONS_OUTPUT_FOLDER "${CMAKE_CURRENT_BINARY_DIR}/Qaterial_icons")
set(QATERIAL_ICONS_CLASS_FILE "${QATERIAL_ICONS_OUTPUT_FOLDER}/Qaterial/Icons.hpp")
qaterial_generate_icons_class(${QATERIAL_ICONS_CLASS_FILE})

# ───── QML SOURCES ─────

set(QATERIAL_SOURCE_DIR src/Qaterial)

set(QATERIAL_DISPLAY_SRCS
  ${QATERIAL_ICONS_CLASS_FILE}
  ${QATERIAL_SOURCE_DIR}/IconDescription.hpp
  ${QATERIAL_SOURCE_DIR}/IconDescription.cpp
  ${QATERIAL_SOURCE_DIR}/IconLabelPositionner.hpp
  ${QATERIAL_SOURCE_DIR}/IconLabelPositionner.cpp
  ${QATERIAL_SOURCE_DIR}/IconLabelImpl.hpp
  ${QATERIAL_SOURCE_DIR}/IconLabelImpl.cpp
)

set(QATERIAL_THEME_SRCS
  ${QATERIAL_SOURCE_DIR}/ColorTheme.hpp
  ${QATERIAL_SOURCE_DIR}/ColorTheme.cpp
  ${QATERIAL_SOURCE_DIR}/TextTheme.hpp
  ${QATERIAL_SOURCE_DIR}/TextTheme.cpp
  ${QATERIAL_SOURCE_DIR}/Theme.hpp
  ${QATERIAL_SOURCE_DIR}/Theme.cpp
)

set(QATERIAL_LAYOUT_SRCS
  ${QATERIAL_SOURCE_DIR}/Layout.hpp
  ${QATERIAL_SOURCE_DIR}/Layout.cpp
)

set(QATERIAL_IO_SRCS
  ${QATERIAL_SOURCE_DIR}/TextFile.hpp
  ${QATERIAL_SOURCE_DIR}/TextFile.cpp
  ${QATERIAL_SOURCE_DIR}/Clipboard.hpp
  ${QATERIAL_SOURCE_DIR}/Clipboard.cpp
  ${QATERIAL_SOURCE_DIR}/FolderTreeModel.hpp
  ${QATERIAL_SOURCE_DIR}/FolderTreeModel.cpp
)

set(QATERIAL_NAVIGATION_SRCS
  ${QATERIAL_SOURCE_DIR}/StepperElement.hpp
  ${QATERIAL_SOURCE_DIR}/StepperElement.cpp
  ${QATERIAL_SOURCE_DIR}/TreeElement.hpp
  ${QATERIAL_SOURCE_DIR}/TreeElement.cpp
)

set(QATERIAL_UTILS_SRCS
  ${QATERIAL_SOURCE_DIR}/Qaterial.hpp
  ${QATERIAL_SOURCE_DIR}/Export.hpp
  ${QATERIAL_SOURCE_DIR}/Property.hpp
  ${QATERIAL_SOURCE_DIR}/Version.hpp
  ${QATERIAL_SOURCE_DIR}/Version.cpp
  ${QATERIAL_SOURCE_DIR}/Utils.hpp
  ${QATERIAL_SOURCE_DIR}/Utils.cpp
  ${QATERIAL_SOURCE_DIR}/Logger.hpp
  ${QATERIAL_SOURCE_DIR}/Logger.cpp
)

set(QATERIAL_SRCS
  ${QATERIAL_DISPLAY_SRCS}
  ${QATERIAL_THEME_SRCS}
  ${QATERIAL_LAYOUT_SRCS}
  ${QATERIAL_IO_SRCS}
  ${QATERIAL_NAVIGATION_SRCS}
  ${QATERIAL_UTILS_SRCS}
)

source_group("Display" FILES ${QATERIAL_DISPLAY_SRCS})
source_group("Theme" FILES ${QATERIAL_THEME_SRCS})
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
target_include_directories(${QATERIAL_TARGET} PUBLIC src ${QATERIAL_ICONS_OUTPUT_FOLDER})
if(QATERIAL_ENABLE_PCH AND COMMAND target_precompile_headers)
  target_precompile_headers(${QATERIAL_TARGET} PRIVATE src/Qaterial/Pch/Pch.hpp)
endif()

target_link_libraries(${QATERIAL_TARGET} PRIVATE
  ${QATERIAL_TARGET}::Icons
  ${QATERIAL_TARGET}::Fonts
  ${QATERIAL_TARGET}::Components
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
  include(${PROJECT_SOURCE_DIR}/cmake/FetchQtStaticCMake.cmake)
  qt_generate_qml_plugin_import(${QATERIAL_TARGET} QML_SRC ${CMAKE_CURRENT_SOURCE_DIR}/qml)
  qt_generate_plugin_import(${QATERIAL_TARGET})
endif()

if(MSVC)
  target_compile_options(${QATERIAL_TARGET} PUBLIC -bigobj)
endif()

# ───── QATERIAL TESTS ─────

if(QATERIAL_ENABLE_TESTS)
  enable_testing()
  add_subdirectory(tests)
endif()
