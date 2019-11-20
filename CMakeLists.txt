#
#   Qaterial CMake script by Olivier Le Doeuff
#

cmake_minimum_required(VERSION 3.0.0 FATAL_ERROR)

# ┌──────────────────────────────────────────────────────────────────┐
# │                       PROJECT SETTINGS                           │
# └──────────────────────────────────────────────────────────────────┘

set(QATERIAL_VERSION_MAJOR 1)
set(QATERIAL_VERSION_MINOR 1)
set(QATERIAL_VERSION_PATCH 0)
if( EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/.git" )
    execute_process(
        COMMAND git describe --always
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        OUTPUT_VARIABLE QATERIAL_VERSION_TAG
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )
endif()
if(NOT QATERIAL_VERSION_TAG)
    set(QATERIAL_VERSION_TAG 00000000)
endif()
set( QATERIAL_VERSION_TAG_HEX 0x${QATERIAL_VERSION_TAG})
set( QATERIAL_VERSION ${QATERIAL_VERSION_MAJOR}.${QATERIAL_VERSION_MINOR}.${QATERIAL_VERSION_PATCH} CACHE STRING "Version of Qaterial" )

# General
set( QATERIAL_PROJECT "Qaterial" CACHE STRING "Project Name")
set( QATERIAL_TARGET ${QATERIAL_PROJECT} CACHE STRING "Target Name" )
set( QATERIAL_FOLDER_PREFIX ${QATERIAL_PROJECT} CACHE STRING "Prefix folder for all Qaterial generated targets in generated project (only decorative)" )

set( QATERIAL_BUILD_SHARED OFF CACHE BOOL "Build as a shared library" )

set( QATERIAL_USE_NAMESPACE ON CACHE BOOL "Should the library be compiled with a namespace. Default: ON" )
set( QATERIAL_NAMESPACE "Qaterial" CACHE STRING "Namespace of the library is QATERIAL_USE_NAMESPACE is ON. Default : Qaterial" )

project( ${QATERIAL_PROJECT} VERSION ${QATERIAL_VERSION} LANGUAGES CXX )
set_property(GLOBAL PROPERTY USE_FOLDERS ON)
set( CMAKE_CXX_STANDARD 11 )

# LOG OPTIONS

message( STATUS "------ ${QATERIAL_TARGET} Configuration ------" )

# General
message( STATUS "QATERIAL_PROJECT                : ${QATERIAL_PROJECT}" )
message( STATUS "QATERIAL_TARGET                 : ${QATERIAL_TARGET}" )
message( STATUS "QATERIAL_VERSION                : ${QATERIAL_VERSION}" )
message( STATUS "QATERIAL_VERSION_TAG_HEX        : ${QATERIAL_VERSION_TAG_HEX}" )
message( STATUS "QATERIAL_BUILD_SHARED           : ${QATERIAL_BUILD_SHARED}" )
message( STATUS "QATERIAL_FOLDER_PREFIX          : ${QATERIAL_FOLDER_PREFIX}" )

message( STATUS "------ ${QATERIAL_TARGET} End Configuration ------" )

# ┌──────────────────────────────────────────────────────────────────┐
# │                         QT5 CMAKE                                │
# └──────────────────────────────────────────────────────────────────┘

#[[set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM BOTH)
message(STATUS "CMAKE_FIND_ROOT_PATH : " ${CMAKE_FIND_ROOT_PATH})]]
find_package(Qt5Core CONFIG REQUIRED CMAKE_FIND_ROOT_PATH_BOTH)
find_package(Qt5Quick CONFIG REQUIRED CMAKE_FIND_ROOT_PATH_BOTH)
find_package(Qt5QuickControls2 CONFIG REQUIRED CMAKE_FIND_ROOT_PATH_BOTH)
find_package(Qt5QuickCompiler CONFIG REQUIRED CMAKE_FIND_ROOT_PATH_BOTH)

# ┌──────────────────────────────────────────────────────────────────┐
# │              ADD SOURCE TO QT QUICK COMPILER                     │
# └──────────────────────────────────────────────────────────────────┘

# Add qml to the qtquick compiler
qtquick_compiler_add_resources(QATERIAL_QML_RES ${CMAKE_CURRENT_SOURCE_DIR}/qml/Qaterial.qrc)

# Trick to rerun cmake each time qml.qrc is updated
configure_file(
  ${CMAKE_CURRENT_SOURCE_DIR}/qml/Qaterial.qrc
  ${CMAKE_CURRENT_BINARY_DIR}/Qaterial.junk
)

# Dont Run Moc on cpp file generated from cpp
foreach(QATERIAL_QML_FILE ${QATERIAL_QML_RES})
    set_property(SOURCE ${QATERIAL_QML_FILE} PROPERTY SKIP_AUTOMOC ON)
    source_group( "QmlMoc Files" FILES ${QATERIAL_QML_FILE} )
endforeach()

# We use every qml file inside the IDE.
file(GLOB_RECURSE QATERIAL_QML_SRCS ${CMAKE_CURRENT_SOURCE_DIR}/qml/*.qml)

# Set file in folder, good for visualization inside IDE
foreach(_source IN ITEMS ${QATERIAL_QML_SRCS})
    get_filename_component(_source_path "${_source}" PATH)
    file(RELATIVE_PATH _source_path_rel ${CMAKE_CURRENT_SOURCE_DIR}/qml "${_source_path}")
    string(REPLACE "/" "\\" _group_path "${_source_path_rel}")
    source_group("Qml Files\\${_group_path}" FILES "${_source}")
endforeach()


set(QATERIAL_SRCS
    ${QATERIAL_QML_RES}
    ${CMAKE_CURRENT_SOURCE_DIR}/src/include/Qaterial.hpp
    ${CMAKE_CURRENT_SOURCE_DIR}/src/Qaterial.cpp
    ${QATERIAL_QML_SRCS}
    )

# ┌──────────────────────────────────────────────────────────────────┐
# │                        CREATE TARGET                             │
# └──────────────────────────────────────────────────────────────────┘

if(${QATERIAL_BUILD_SHARED})

    add_library( ${QATERIAL_TARGET} SHARED ${QATERIAL_SRCS} )
    target_compile_definitions( ${QATERIAL_TARGET} PUBLIC -DQATERIAL_SHARED )

else()

    add_library( ${QATERIAL_TARGET} STATIC ${QATERIAL_SRCS} )
    target_compile_definitions( ${QATERIAL_TARGET} PUBLIC -DQATERIAL_STATIC )

endif()

# Set public include directory
target_include_directories( ${QATERIAL_TARGET} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/src/include )

# Avoid libnQaterial on darwin for example.
set_target_properties(${QATERIAL_TARGET} PROPERTIES PREFIX "")

if(QATERIAL_FOLDER_PREFIX)
    set_target_properties(${QATERIAL_TARGET} PROPERTIES FOLDER ${QATERIAL_FOLDER_PREFIX})
endif() # QATERIAL_FOLDER_PREFIX

# Version
target_compile_definitions( ${QATERIAL_TARGET} PRIVATE -DQATERIAL_VERSION_MAJOR=${QATERIAL_VERSION_MAJOR} )
target_compile_definitions( ${QATERIAL_TARGET} PRIVATE -DQATERIAL_VERSION_MINOR=${QATERIAL_VERSION_MINOR} )
target_compile_definitions( ${QATERIAL_TARGET} PRIVATE -DQATERIAL_VERSION_PATCH=${QATERIAL_VERSION_PATCH} )
target_compile_definitions( ${QATERIAL_TARGET} PRIVATE -DQATERIAL_VERSION_TAG=${QATERIAL_VERSION_TAG} )
target_compile_definitions( ${QATERIAL_TARGET} PRIVATE -DQATERIAL_VERSION_TAG_HEX=${QATERIAL_VERSION_TAG_HEX} )

if(QATERIAL_USE_NAMESPACE)
    target_compile_definitions( ${QATERIAL_TARGET} PUBLIC -DQATERIAL_USE_NAMESPACE )
    target_compile_definitions( ${QATERIAL_TARGET} PUBLIC -DQATERIAL_NAMESPACE=${QATERIAL_NAMESPACE} )
endif() # QATERIAL_USE_NAMESPACE

# We need autorcc to generate file and automoc for version
set_target_properties(${QATERIAL_TARGET} PROPERTIES AUTORCC TRUE)
set_target_properties(${QATERIAL_TARGET} PROPERTIES AUTOMOC TRUE)
## Require a certain amount of qt library
qt5_use_modules( ${QATERIAL_TARGET} Core Gui Svg Xml XmlPatterns Quick QuickControls2 )
