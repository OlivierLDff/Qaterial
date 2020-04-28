#
#   Qaterial CMake script by Olivier Le Doeuff
#

cmake_minimum_required(VERSION 3.14.0 FATAL_ERROR)

# ───── DEPENDENCIES ─────

set(SPDLOG_REPOSITORY "https://github.com/gabime/spdlog" CACHE STRING "Repository of spdlog")
set(SPDLOG_TAG "v1.x" CACHE STRING "Git tag/branch of spdlog")

set(QTSTATICCMAKE_REPOSITORY "https://github.com/OlivierLDff/QtStaticCMake.git" CACHE STRING "QtStaticCMake repository, can be a local URL")
set(QTSTATICCMAKE_TAG "master" CACHE STRING "QtStaticCMake git tag")

# ───── PROJECT OPTIONS ─────

set(QATERIAL_VERSION_MAJOR 1)
set(QATERIAL_VERSION_MINOR 2)
set(QATERIAL_VERSION_PATCH 1)
if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/.git")
  execute_process(
    COMMAND git rev-parse --short HEAD
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    OUTPUT_VARIABLE QATERIAL_VERSION_TAG
    OUTPUT_STRIP_TRAILING_WHITESPACE
)
endif()
if(NOT QATERIAL_VERSION_TAG)
  set(QATERIAL_VERSION_TAG 00000000)
endif()
set(QATERIAL_VERSION_TAG_HEX 0x${QATERIAL_VERSION_TAG})
set(QATERIAL_VERSION ${QATERIAL_VERSION_MAJOR}.${QATERIAL_VERSION_MINOR}.${QATERIAL_VERSION_PATCH} CACHE STRING "Version of Qaterial")

# Options
set(QATERIAL_PROJECT "Qaterial" CACHE STRING "Project Name")
set(QATERIAL_TARGET ${QATERIAL_PROJECT} CACHE STRING "Target Name")
set(QATERIAL_FOLDER_PREFIX ${QATERIAL_PROJECT} CACHE STRING "Prefix folder for all Qaterial generated targets in generated project (only decorative)")
set(QATERIAL_BUILD_SHARED OFF CACHE BOOL "Build as a shared library")

project(${QATERIAL_PROJECT} VERSION ${QATERIAL_VERSION} LANGUAGES CXX)
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

message(STATUS "------ ${QATERIAL_TARGET} Configuration ------")
message(STATUS "QATERIAL_PROJECT                : ${QATERIAL_PROJECT}")
message(STATUS "QATERIAL_TARGET                 : ${QATERIAL_TARGET}")
message(STATUS "QATERIAL_VERSION                : ${QATERIAL_VERSION}")
message(STATUS "QATERIAL_VERSION_TAG_HEX        : ${QATERIAL_VERSION_TAG_HEX}")
message(STATUS "QATERIAL_BUILD_SHARED           : ${QATERIAL_BUILD_SHARED}")
message(STATUS "QATERIAL_FOLDER_PREFIX          : ${QATERIAL_FOLDER_PREFIX}")
message(STATUS "------ ${QATERIAL_TARGET} End Configuration ------")

# ───── QT DEPENDENCIES ─────

find_package(Qt5Core            CONFIG REQUIRED NO_CMAKE_SYSTEM_PATH)
find_package(Qt5Gui             CONFIG REQUIRED NO_CMAKE_SYSTEM_PATH)
find_package(Qt5Qml             CONFIG REQUIRED NO_CMAKE_SYSTEM_PATH)
find_package(Qt5QmlWorkerScript CONFIG QUIET    NO_CMAKE_SYSTEM_PATH)
find_package(Qt5Quick           CONFIG REQUIRED NO_CMAKE_SYSTEM_PATH)
find_package(Qt5QuickControls2  CONFIG REQUIRED NO_CMAKE_SYSTEM_PATH)
find_package(Qt5Svg             CONFIG REQUIRED NO_CMAKE_SYSTEM_PATH)
find_package(Qt5Xml             CONFIG REQUIRED NO_CMAKE_SYSTEM_PATH)
find_package(Qt5QuickCompiler   CONFIG REQUIRED NO_CMAKE_SYSTEM_PATH)

# ───── FETCH DEPEDENCIES ─────

include(FetchContent)

# spdlog
FetchContent_Declare(
  spdlog
  GIT_REPOSITORY ${SPDLOG_REPOSITORY}
  GIT_TAG        ${SPDLOG_TAG}
  GIT_SHALLOW    1
  )

# QtStaticCMake
FetchContent_Declare(
  QtStaticCMake
  GIT_REPOSITORY ${QTSTATICCMAKE_REPOSITORY}
  GIT_TAG        ${QTSTATICCMAKE_TAG}
  )

FetchContent_MakeAvailable(spdlog)

# ───── QML SOURCES ─────

file(GLOB_RECURSE QATERIAL_QML_SRCS qml/*.qml)

foreach(SOURCE IN ITEMS ${QATERIAL_QML_SRCS})
  get_filename_component(SOURCE_PATH "${SOURCE}" PATH)
  file(RELATIVE_PATH SOURCE_PATH_REL ${CMAKE_CURRENT_SOURCE_DIR}/qml "${SOURCE_PATH}")
  string(REPLACE "/" "\\" GROUP_PATH "${SOURCE_PATH_REL}")
  source_group("Qml\\${GROUP_PATH}" FILES "${SOURCE}")
endforeach()

# Add qml to the qtquick compiler
qtquick_compiler_add_resources(QATERIAL_QML_RES ${CMAKE_CURRENT_SOURCE_DIR}/qml/Qaterial.qrc)

# Trick to rerun cmake each time Qaterial.qrc is updated
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/qml/Qaterial.qrc ${CMAKE_CURRENT_BINARY_DIR}/Qaterial.qrc.junk)

# Dont Run Moc on cpp file generated from qml
foreach(QATERIAL_CURRENT_QML_FILE ${QATERIAL_QML_RES})
  set_property(SOURCE ${QATERIAL_CURRENT_QML_FILE} PROPERTY SKIP_AUTOMOC ON)
  source_group("Qml\\QtQuickCompiler Files" FILES ${QATERIAL_CURRENT_QML_FILE})
endforeach()

set(QATERIAL_UTILS_SRCS
  ${CMAKE_CURRENT_SOURCE_DIR}/include/Qaterial/Qaterial.hpp
  ${CMAKE_CURRENT_SOURCE_DIR}/include/Qaterial/Export.hpp
  ${CMAKE_CURRENT_SOURCE_DIR}/include/Qaterial/Version.hpp
  ${CMAKE_CURRENT_SOURCE_DIR}/include/Qaterial/Utils.hpp
  ${CMAKE_CURRENT_SOURCE_DIR}/include/Qaterial/Logger.hpp

  ${CMAKE_CURRENT_SOURCE_DIR}/src/Version.cpp
  ${CMAKE_CURRENT_SOURCE_DIR}/src/Utils.cpp
  ${CMAKE_CURRENT_SOURCE_DIR}/src/Logger.cpp
  )

set(QATERIAL_SRCS
  ${QATERIAL_UTILS_SRCS}
  ${QATERIAL_QML_RES}
  ${QATERIAL_QML_SRCS}
  )

source_group("Utils" FILES ${QATERIAL_UTILS_SRCS})

# ┌──────────────────────────────────────────────────────────────────┐
# │                        CREATE TARGET                             │
# └──────────────────────────────────────────────────────────────────┘

if(${QATERIAL_BUILD_SHARED})
  add_library(${QATERIAL_TARGET} SHARED ${QATERIAL_SRCS})
  target_compile_definitions(${QATERIAL_TARGET} PUBLIC -DQATERIAL_SHARED)
else()
  add_library(${QATERIAL_TARGET} STATIC ${QATERIAL_SRCS})
  target_compile_definitions(${QATERIAL_TARGET} PUBLIC -DQATERIAL_STATIC)
endif()

target_compile_features(${QATERIAL_TARGET}    PUBLIC cxx_std_11)
target_include_directories(${QATERIAL_TARGET} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)
target_link_libraries(${QATERIAL_TARGET}      PUBLIC
  spdlog
  Qt5::Core
  Qt5::Gui
  Qt5::Svg
  Qt5::Xml
  Qt5::Qml
  Qt5::Quick
  Qt5::QuickControls2
  )
set_target_properties(${QATERIAL_TARGET} PROPERTIES AUTORCC TRUE)
set_target_properties(${QATERIAL_TARGET} PROPERTIES AUTOMOC TRUE)

# Version
target_compile_definitions(${QATERIAL_TARGET} PRIVATE -DQATERIAL_VERSION_MAJOR=${QATERIAL_VERSION_MAJOR})
target_compile_definitions(${QATERIAL_TARGET} PRIVATE -DQATERIAL_VERSION_MINOR=${QATERIAL_VERSION_MINOR})
target_compile_definitions(${QATERIAL_TARGET} PRIVATE -DQATERIAL_VERSION_PATCH=${QATERIAL_VERSION_PATCH})
target_compile_definitions(${QATERIAL_TARGET} PRIVATE -DQATERIAL_VERSION_TAG=${QATERIAL_VERSION_TAG})
target_compile_definitions(${QATERIAL_TARGET} PRIVATE -DQATERIAL_VERSION_TAG_HEX=${QATERIAL_VERSION_TAG_HEX})

if(QATERIAL_FOLDER_PREFIX)
  set_target_properties(${QATERIAL_TARGET} PROPERTIES FOLDER ${QATERIAL_FOLDER_PREFIX})
endif()

# Correctly link to static qt
get_target_property(QT_TARGET_TYPE Qt5::Core TYPE)
if(${QT_TARGET_TYPE} STREQUAL "STATIC_LIBRARY")
  FetchContent_MakeAvailable(QtStaticCMake)
  qt_generate_qml_plugin_import(${QATERIAL_TARGET}
    QML_SRC ${CMAKE_CURRENT_SOURCE_DIR}/qml
    VERBOSE
    )
endif()

if(TARGET Qt5::QmlWorkerScript)
  target_link_libraries(${QATERIAL_TARGET} PUBLIC Qt5::QmlWorkerScript)
endif()