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

# Generate a QML file with icon path properties
#
# Usage:
# qaterial_generate_icons_qml(<OUTPUT_FILE>
#   SOURCE_DIR <path>
#   PREFIX <qrc_prefix>
#   GLOB_EXPRESSION <pattern>)
#
function(qaterial_generate_icons_qml OUTPUT_FILE)

  set(QT_QRC_OPTIONS ALWAYS_OVERWRITE)
  set(QT_QRC_ONE_VALUE_ARG PREFIX SOURCE_DIR)
  set(QT_QRC_MULTI_VALUE_ARG GLOB_EXPRESSION)

  cmake_parse_arguments(ARGGEN "${QT_QRC_OPTIONS}" "${QT_QRC_ONE_VALUE_ARG}" "${QT_QRC_MULTI_VALUE_ARG}" ${ARGN})

  get_filename_component(OUT_FILENAME_ABS ${OUTPUT_FILE} ABSOLUTE)

  if(ARGGEN_ALWAYS_OVERWRITE OR NOT EXISTS ${OUT_FILENAME_ABS})

    if(NOT ARGGEN_GLOB_EXPRESSION)
      set(ARGGEN_GLOB_EXPRESSION "*")
    endif()

    list(TRANSFORM ARGGEN_GLOB_EXPRESSION PREPEND "${ARGGEN_SOURCE_DIR}/")

    # Fetch files that are going to be turned into properties
    file(GLOB RES_FILES ${ARGGEN_GLOB_EXPRESSION})

    set(OUT_CONTENT "")
    # Write QML Header
    string(APPEND OUT_CONTENT
      "// File auto generated with CMake qaterial_generate_icons_qml.\n"
      "// Everything written here will be lost.\n\n"
      "import QtQml\n\n"
      "QtObject\n"
      "{\n"
    )

    set(QRC_PATH "qrc:/${ARGGEN_PREFIX}")

    foreach(RES_FILE ${RES_FILES})
      get_filename_component(FILENAME_WE ${RES_FILE} NAME_WE)
      get_filename_component(FILENAME ${RES_FILE} NAME)
      get_filename_component(FILENAME_EXT ${RES_FILE} LAST_EXT)

      if(NOT ${FILENAME_EXT} STREQUAL ".qrc")

        set(PROPERTY_NAME_LIST ${FILENAME_WE})
        # Create a list from kebab-case/snake_case
        string(REGEX REPLACE "[_ -]" ";" PROPERTY_NAME_LIST ${PROPERTY_NAME_LIST})

        set(PROPERTY_NAME "")

        set(PROPERTY_WORD_INDEX 0)
        foreach(PROPERTY_WORD ${PROPERTY_NAME_LIST})
          if(PROPERTY_WORD_INDEX EQUAL 0)
            # First word: lowercase first letter (camelCase)
            string(SUBSTRING ${PROPERTY_WORD} 0 1 FIRST_LETTER)
            string(TOLOWER ${FIRST_LETTER} FIRST_LETTER)
            string(REGEX REPLACE "^.(.*)" "${FIRST_LETTER}\\1" PROPERTY_WORD "${PROPERTY_WORD}")
          else()
            # Subsequent words: uppercase first letter
            string(SUBSTRING ${PROPERTY_WORD} 0 1 FIRST_LETTER)
            string(TOUPPER ${FIRST_LETTER} FIRST_LETTER)
            string(REGEX REPLACE "^.(.*)" "${FIRST_LETTER}\\1" PROPERTY_WORD "${PROPERTY_WORD}")
          endif()
          set(PROPERTY_NAME "${PROPERTY_NAME}${PROPERTY_WORD}")
          math(EXPR PROPERTY_WORD_INDEX "${PROPERTY_WORD_INDEX}+1")
        endforeach()

        # Handle reserved JS/QML keywords
        set(FORBIDDEN_PROPERTY_WORDS id index model modelData console do if in for let new try var case else enum eval null this true void with await break catch class const false super throw while yield delete export import public return static switch typeof default extends finally package private continue debugger function arguments interface protected implements instanceof linux)

        if (${PROPERTY_NAME} IN_LIST FORBIDDEN_PROPERTY_WORDS)
          set(PROPERTY_NAME ${PROPERTY_NAME}_)
        endif()

        string(APPEND OUT_CONTENT
          "    readonly property string ${PROPERTY_NAME}: \"${QRC_PATH}/${FILENAME}\"\n")
      endif()
    endforeach()

    string(APPEND OUT_CONTENT
      "}\n"
    )

    # Write file to temp then copy to original if there are diff
    file(WRITE ${OUT_FILENAME_ABS}.temp ${OUT_CONTENT})
    execute_process(COMMAND ${CMAKE_COMMAND} -E copy_if_different ${OUT_FILENAME_ABS}.temp ${OUT_FILENAME_ABS})
    file(REMOVE ${OUT_FILENAME_ABS}.temp)

  else()
    message(STATUS "${OUT_FILENAME_ABS} already generated, skip generation for faster cmake.")
  endif()

endfunction()
