include(CMakeParseArguments)

# Generate a qrc file that pack every file inside a folder.
#
# Example:
# qt_generate_qrc(QATERIAL_QML_ICONS_QRC
#  SOURCE_DIR qml/Icons
#  NAME QaterialIcons.qrc
#  PREFIX "Qaterial/Icons"
#  GLOB_EXPRESSION "*.svg")
#
# Usage:
# qt_generate_qrc(<var> [options...])
#
# VAR: Absolute path to the generated qrc file
# - PREFIX: qrc prefix for every file in folder. <qresource prefix="/${PREFIX}">
# - SOURCE_DIR: folder containing file to pack in qrc
#               The file is also generated in that folder
# - NAME: Name of the file (should include .qrc extension, or whatever extension you want)
# - GLOB_EXPRESSION: Expression to filter which file are going to be embedded in the qrc.
#
function(qt_generate_qrc VAR)

  set(QT_QRC_OPTIONS VERBOSE)
  set(QT_QRC_ONE_VALUE_ARG PREFIX
    SOURCE_DIR
    NAME
    )
  set(QT_QRC_MULTI_VALUE_ARG GLOB_EXPRESSION)

  # parse the macro arguments
  cmake_parse_arguments(ARGGEN "${QT_QRC_OPTIONS}" "${QT_QRC_ONE_VALUE_ARG}" "${QT_QRC_MULTI_VALUE_ARG}" ${ARGN})

  # Create correct filename
  set(OUT_FILENAME ${ARGGEN_SOURCE_DIR}/${ARGGEN_NAME})
  get_filename_component(OUT_FILENAME_ABS ${OUT_FILENAME} ABSOLUTE)
  # Set output variable
  set(${VAR} ${OUT_FILENAME_ABS} PARENT_SCOPE)

  if(NOT ARGGEN_GLOB_EXPRESSION)
    set(ARGGEN_GLOB_EXPRESSION "*")
  endif()

  list(TRANSFORM ARGGEN_GLOB_EXPRESSION PREPEND "${ARGGEN_SOURCE_DIR}/")

  file(GLOB RES_FILES ${ARGGEN_GLOB_EXPRESSION})

  file(WRITE ${OUT_FILENAME_ABS}
    "<!-- File auto generated with CMake qt_generate_qrc. Everything written here will be lost. -->\n"
    "<RCC>\n"
    "  <qresource prefix=\"/${ARGGEN_PREFIX}\">\n")

  foreach(RES_FILE ${RES_FILES})
    get_filename_component(FILENAME ${RES_FILE} NAME)
    get_filename_component(FILENAME_EXT ${RES_FILE} LAST_EXT)

    if(NOT FILENAME_EXT OR NOT ${FILENAME_EXT} STREQUAL ".qrc")
      file(APPEND ${OUT_FILENAME_ABS} "    <file>${FILENAME}</file>\n")
      if(ARGGEN_VERBOSE)
        message(STATUS "Add ${FILENAME} in ${ARGGEN_NAME}")
      endif()
    endif()
  endforeach()

  file(APPEND ${OUT_FILENAME_ABS}
    "  </qresource>\n"
    "</RCC>\n")

endfunction()
