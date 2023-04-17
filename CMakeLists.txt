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

cmake_minimum_required(VERSION 3.15.0 FATAL_ERROR)

set(QATERIAL_MAIN_PROJECT OFF)
if (CMAKE_CURRENT_SOURCE_DIR STREQUAL CMAKE_SOURCE_DIR)
  set(QATERIAL_MAIN_PROJECT ON)
endif()

# ───── PROJECT OPTIONS ─────

include(cmake/Version.cmake)

set(QATERIAL_PROJECT "Qaterial" CACHE STRING "Project Name")
set(QATERIAL_TARGET ${QATERIAL_PROJECT} CACHE STRING "Target Name")
set(QATERIAL_FOLDER_PREFIX ${QATERIAL_PROJECT} CACHE STRING "Prefix folder for all Qaterial generated targets in generated project (only decorative)")
set(QATERIAL_VERBOSE ${QATERIAL_MAIN_PROJECT} CACHE BOOL "Qaterial log configuration")
set(QATERIAL_BUILD_SHARED OFF CACHE BOOL "Build as a shared library")
set(QATERIAL_ENABLE_TESTS OFF CACHE BOOL "Build Qaterial test executable")
set(QATERIAL_ENABLE_PCH ON CACHE BOOL
 "Enable precompile headers support for 'Qaterial'. \"
 Only work if CMake support 'target_precompile_headers'. \"
 This can speed up compilation time.")
set(QATERIAL_ENABLE_UNITY_BUILD ON CACHE BOOL "Qaterial source files will be combined into batches for faster compilation.")
set(QATERIAL_ENABLE_HIGHDPIFIX ON CACHE BOOL "Fix high dpi at application startup without any additional code")

set(QATERIAL_ENABLE_ICONS ON CACHE BOOL "Embed Mdi Icons in Qaterial.Icons (MATERIALDESIGNICONS_REPOSITORY)")
set(QATERIAL_ICONS "*.svg" CACHE STRING "Filter embedded icons")

set(QATERIAL_ENABLE_ROBOTO ON CACHE BOOL "Embed to qrc Roboto Regular & Medium")
set(QATERIAL_ENABLE_ROBOTOMONO ON CACHE BOOL "Embed to qrc RobotoMono Regular")
set(QATERIAL_ENABLE_LATO ON CACHE BOOL "Embed to qrc Lato Regular")

set(QATERIAL_ENABLE_INSTALL ${QATERIAL_MAIN_PROJECT} CACHE BOOL "Generate the install target")

project(${QATERIAL_PROJECT} VERSION ${QATERIAL_VERSION} LANGUAGES CXX)
if(QATERIAL_MAIN_PROJECT)
  set_property(GLOBAL PROPERTY USE_FOLDERS ON)
endif()

if(QATERIAL_VERBOSE)

  message(STATUS "------ ${QATERIAL_TARGET} Configuration ------")

  message(STATUS "QATERIAL_PROJECT                : ${QATERIAL_PROJECT}")
  message(STATUS "QATERIAL_TARGET                 : ${QATERIAL_TARGET}")
  message(STATUS "QATERIAL_VERSION                : ${QATERIAL_VERSION}")
  message(STATUS "QATERIAL_VERSION_TAG_HEX        : ${QATERIAL_VERSION_TAG_HEX}")
  message(STATUS "QATERIAL_BUILD_SHARED           : ${QATERIAL_BUILD_SHARED}")
  message(STATUS "QATERIAL_FOLDER_PREFIX          : ${QATERIAL_FOLDER_PREFIX}")
  message(STATUS "QATERIAL_ENABLE_PCH             : ${QATERIAL_ENABLE_PCH}")
  message(STATUS "QATERIAL_ENABLE_UNITY_BUILD     : ${QATERIAL_ENABLE_UNITY_BUILD}")
  message(STATUS "QATERIAL_ENABLE_HIGHDPIFIX      : ${QATERIAL_ENABLE_HIGHDPIFIX}")

  message(STATUS "QATERIAL_ENABLE_ICONS           : ${QATERIAL_ENABLE_ICONS}")
  message(STATUS "QATERIAL_ICONS                  : ${QATERIAL_ICONS}")

  message(STATUS "QATERIAL_ENABLE_ROBOTO          : ${QATERIAL_ENABLE_ROBOTO}")
  message(STATUS "QATERIAL_ENABLE_ROBOTOMONO      : ${QATERIAL_ENABLE_ROBOTOMONO}")
  message(STATUS "QATERIAL_ENABLE_LATO            : ${QATERIAL_ENABLE_LATO}")

  message(STATUS "QATERIAL_ENABLE_TESTS           : ${QATERIAL_ENABLE_TESTS}")
  message(STATUS "QATERIAL_ENABLE_INSTALL         : ${QATERIAL_ENABLE_INSTALL}")


  message(STATUS "------ ${QATERIAL_TARGET} End Configuration ------")

endif()

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

# ───── FETCH DEPENDENCIES ─────

include(cmake/FetchQOlm.cmake)
include(cmake/FetchQtGeneratorCMake.cmake)

# ───── RESSOURCES ─────

add_subdirectory(qml)
include(cmake/QaterialGenerateIcons.cmake)
set(QATERIAL_ICONS_OUTPUT_FOLDER "${CMAKE_CURRENT_BINARY_DIR}/Qaterial_icons")
set(QATERIAL_ICONS_CLASS_FILE "${QATERIAL_ICONS_OUTPUT_FOLDER}/Qaterial/Display/Icons.hpp")
set(QATERIAL_ICONS_SRC_FILE "${QATERIAL_ICONS_OUTPUT_FOLDER}/Qaterial/Display/Icons.cpp")
qaterial_generate_icons_class(${QATERIAL_ICONS_CLASS_FILE} ${QATERIAL_ICONS_SRC_FILE})
set(QATERIAL_GEN_SRCS
  ${QATERIAL_ICONS_CLASS_FILE}
  ${QATERIAL_ICONS_SRC_FILE}
)

# ───── QML SOURCES ─────

set(QATERIAL_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/src/Qaterial)

set(QATERIAL_PUBLIC_HEADERS
  ${QATERIAL_SOURCE_DIR}/Qaterial.hpp
  ${QATERIAL_SOURCE_DIR}/Details/Export.hpp
  ${QATERIAL_SOURCE_DIR}/Details/Utils.hpp
)

set(QATERIAL_SRCS
  ${QATERIAL_PUBLIC_HEADERS}
  ${QATERIAL_SOURCE_DIR}/Display/IconDescription.hpp
  ${QATERIAL_SOURCE_DIR}/Display/IconDescription.cpp
  ${QATERIAL_SOURCE_DIR}/Display/IconLabelPositioner.hpp
  ${QATERIAL_SOURCE_DIR}/Display/IconLabelPositioner.cpp
  ${QATERIAL_SOURCE_DIR}/Display/IconLabelImpl.hpp
  ${QATERIAL_SOURCE_DIR}/Display/IconLabelImpl.cpp

  ${QATERIAL_SOURCE_DIR}/Theme/ColorTheme.hpp
  ${QATERIAL_SOURCE_DIR}/Theme/ColorTheme.cpp
  ${QATERIAL_SOURCE_DIR}/Theme/TextTheme.hpp
  ${QATERIAL_SOURCE_DIR}/Theme/TextTheme.cpp
  ${QATERIAL_SOURCE_DIR}/Theme/Theme.hpp
  ${QATERIAL_SOURCE_DIR}/Theme/Theme.cpp

  ${QATERIAL_SOURCE_DIR}/Layout/Layout.hpp
  ${QATERIAL_SOURCE_DIR}/Layout/Layout.cpp

  ${QATERIAL_SOURCE_DIR}/IO/TextFile.hpp
  ${QATERIAL_SOURCE_DIR}/IO/TextFile.cpp
  ${QATERIAL_SOURCE_DIR}/IO/Clipboard.hpp
  ${QATERIAL_SOURCE_DIR}/IO/Clipboard.cpp
  ${QATERIAL_SOURCE_DIR}/IO/FolderTreeModel.hpp
  ${QATERIAL_SOURCE_DIR}/IO/FolderTreeModel.cpp

  ${QATERIAL_SOURCE_DIR}/Navigation/StepperElement.hpp
  ${QATERIAL_SOURCE_DIR}/Navigation/StepperElement.cpp
  ${QATERIAL_SOURCE_DIR}/Navigation/TreeElement.hpp
  ${QATERIAL_SOURCE_DIR}/Navigation/TreeElement.cpp

  ${QATERIAL_SOURCE_DIR}/Details/Property.hpp
  ${QATERIAL_SOURCE_DIR}/Details/Version.hpp
  ${QATERIAL_SOURCE_DIR}/Details/Version.cpp
  ${QATERIAL_SOURCE_DIR}/Details/Utils.cpp
)

if(QATERIAL_ENABLE_HIGHDPIFIX)
  set(QATERIAL_SRCS ${QATERIAL_SRCS}
    ${QATERIAL_SOURCE_DIR}/Details/HighDpiFix.cpp
  )
endif()

source_group(TREE "${QATERIAL_SOURCE_DIR}" FILES ${QATERIAL_SRCS})
source_group(TREE "${QATERIAL_ICONS_OUTPUT_FOLDER}/Qaterial" FILES ${QATERIAL_GEN_SRCS})

set(QATERIAL_SRCS ${QATERIAL_SRCS} ${QATERIAL_GEN_SRCS})

# ───── QATERIAL TARGET ─────

if(${QATERIAL_BUILD_SHARED})
  add_library(${QATERIAL_TARGET} SHARED ${QATERIAL_SRCS})
  target_compile_definitions(${QATERIAL_TARGET} PRIVATE -DQATERIAL_SHARED)
else()
  add_library(${QATERIAL_TARGET} STATIC ${QATERIAL_SRCS})
  target_compile_definitions(${QATERIAL_TARGET} PUBLIC -DQATERIAL_STATIC)
endif()
add_library(${QATERIAL_TARGET}::${QATERIAL_TARGET} ALIAS ${QATERIAL_TARGET})

target_compile_features(${QATERIAL_TARGET} PUBLIC cxx_std_17)
target_include_directories(${QATERIAL_TARGET} PRIVATE src ${QATERIAL_ICONS_OUTPUT_FOLDER})
target_include_directories(${QATERIAL_TARGET} PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src>
  $<INSTALL_INTERFACE:include>
)
if(QATERIAL_ENABLE_PCH AND COMMAND target_precompile_headers)
  target_precompile_headers(${QATERIAL_TARGET} PRIVATE src/Qaterial/Pch/Pch.hpp)
endif()

target_link_libraries(${QATERIAL_TARGET} PRIVATE
  ${QATERIAL_TARGET}::Icons
  ${QATERIAL_TARGET}::Fonts
  ${QATERIAL_TARGET}::Components
  QOlm::QOlm
  Qt::Core
  Qt::Gui
  Qt::Svg
  Qt::Xml
  Qt::Qml
  Qt::Quick
  Qt::QuickControls2
)

set_target_properties(${QATERIAL_TARGET} PROPERTIES
  AUTOMOC TRUE
)
if(QATERIAL_ENABLE_UNITY_BUILD)
  set_target_properties(${QATERIAL_TARGET} PROPERTIES UNITY_BUILD ON)
endif()

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
if(NOT QATERIAL_ENABLE_INSTALL AND ${QT_TARGET_TYPE} STREQUAL "STATIC_LIBRARY")
  include(${PROJECT_SOURCE_DIR}/cmake/FetchQtStaticCMake.cmake)
  qt_generate_qml_plugin_import(${QATERIAL_TARGET} QML_SRC ${CMAKE_CURRENT_SOURCE_DIR}/qml)
  qt_generate_plugin_import(${QATERIAL_TARGET})
endif()

list(APPEND QML_IMPORTPATH "${CMAKE_CURRENT_SOURCE_DIR}/qml")
list(APPEND QML_IMPORTPATH ${QML_IMPORT_PATH})
list(APPEND QML2_IMPORTPATH "${CMAKE_CURRENT_SOURCE_DIR}/qml")
list(APPEND QML2_IMPORTPATH ${QML2_IMPORT_PATH})

set(QML_IMPORT_PATH "${QML_IMPORTPATH}" CACHE STRING "Qt Creator 4.1 extra qml import paths" FORCE)
set(QML2_IMPORT_PATH "${QML2_IMPORTPATH}" CACHE STRING "Qt Creator 4.1 extra qml import paths" FORCE)


if(MSVC)
  target_compile_options(${QATERIAL_TARGET} PUBLIC -bigobj)
endif()

# ───── QATERIAL TESTS ─────

if(QATERIAL_ENABLE_TESTS)
  enable_testing()
  add_subdirectory(tests)
endif()

# ───── INSTALL ─────

if (QATERIAL_ENABLE_INSTALL)
  include(GNUInstallDirs)
  install(TARGETS ${QATERIAL_TARGET}
    EXPORT ${QATERIAL_TARGET}Targets
  )

  foreach(HDR_FILE ${QATERIAL_PUBLIC_HEADERS})
    get_filename_component(HDR_DIRECTORY ${HDR_FILE} DIRECTORY)
    get_filename_component(ABSOLUTE_HDR_DIRECTORY ${HDR_DIRECTORY} ABSOLUTE)
    file(RELATIVE_PATH RELATIVE_HDR_PATH ${CMAKE_CURRENT_SOURCE_DIR}/src ${ABSOLUTE_HDR_DIRECTORY})
    install(FILES ${HDR_FILE} DESTINATION include/${RELATIVE_HDR_PATH})
  endforeach()

  include(CMakePackageConfigHelpers)
  write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/${QATERIAL_TARGET}/${QATERIAL_TARGET}ConfigVersion.cmake"
    VERSION ${QATERIAL_VERSION}
    COMPATIBILITY AnyNewerVersion
  )

  export(EXPORT ${QATERIAL_TARGET}Targets
    FILE "${CMAKE_CURRENT_BINARY_DIR}/${QATERIAL_TARGET}/${QATERIAL_TARGET}Targets.cmake"
    NAMESPACE ${QATERIAL_TARGET}::
  )

  configure_file(cmake/${QATERIAL_TARGET}Config.cmake.in
    "${CMAKE_CURRENT_BINARY_DIR}/${QATERIAL_TARGET}/${QATERIAL_TARGET}Config.cmake"
    @ONLY
  )

  set(ConfigPackageLocation lib/cmake/${QATERIAL_TARGET})
  install(EXPORT ${QATERIAL_TARGET}Targets
    FILE
    ${QATERIAL_TARGET}Targets.cmake
    NAMESPACE
    ${QATERIAL_TARGET}::
    DESTINATION
    ${ConfigPackageLocation}
  )
  install(
    FILES
    "${CMAKE_CURRENT_BINARY_DIR}/${QATERIAL_TARGET}/${QATERIAL_TARGET}Config.cmake"
    "${CMAKE_CURRENT_BINARY_DIR}/${QATERIAL_TARGET}/${QATERIAL_TARGET}ConfigVersion.cmake"
    DESTINATION
    ${ConfigPackageLocation}
  )
endif()

# ───── DUMP CONFIG ─────

if(QATERIAL_MAIN_PROJECT)
  include(cmake/PrintConfiguration.cmake)
endif()
