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

# No matter if QATERIAL_ENABLE_ICONS is ON or OFF, always generate something.
# From Qaterial point of view nothing change

include(CMakeParseArguments)

# Generate a QObject with property string containing full qrc path to file.
#
# Example:
# qt_generate_qrc_alias_qt_object(GENERATED_ALIAS_QML_FILENAME
#   SOURCE_DIR path/to/qml/folder
#   NAME path/to/qml/folder/Icons.qml
#   PREFIX "My/Qrc/Prefix"
#   GLOB_EXPRESSION "*.svg"
#   SINGLETON)
#
# Usage:
# qt_generate_qrc_alias_qt_object(<var> [options...])
#
# HEADER: Absolute path to the generated hpp file
# SRC: Absolute path to the generated cpp file
# - SOURCE_DIR: folder containing file to pack in qrc
#               The file is also generated in that folder
# - NAME: Name of the qml file. Can be relative or absolute
# - PREFIX: Prefix appended inside each property value
# - GLOB_EXPRESSION: Expression to filter which file are going to be embedded in the qrc.
# - SINGLETON: Should the object be a singleton
#
function(_qaterial_generate_icons_class HEADER SRC)

  set(QT_QRC_OPTIONS ALWAYS_OVERWRITE)
  set(QT_QRC_ONE_VALUE_ARG PREFIX
    SOURCE_DIR
    NAME
    NAME_CPP
    )
  set(QT_QRC_MULTI_VALUE_ARG GLOB_EXPRESSION)

  # parse the macro arguments
  cmake_parse_arguments(ARGGEN "${QT_QRC_OPTIONS}" "${QT_QRC_ONE_VALUE_ARG}" "${QT_QRC_MULTI_VALUE_ARG}" ${ARGN})

  # Create correct filename
  set(OUT_FILENAME ${ARGGEN_NAME})
  set(OUT_FILENAME_CPP ${ARGGEN_NAME_CPP})
  get_filename_component(OUT_FILENAME_ABS ${OUT_FILENAME} ABSOLUTE)
  get_filename_component(OUT_FILENAME_ABS_CPP ${OUT_FILENAME_CPP} ABSOLUTE)
  # Set output variable
  set(${HEADER} ${OUT_FILENAME_ABS} PARENT_SCOPE)
  set(${SRC} ${OUT_FILENAME_ABS_CPP} PARENT_SCOPE)

  if(ARGGEN_ALWAYS_OVERWRITE OR NOT EXISTS ${OUT_FILENAME_ABS})

    if(NOT ARGGEN_GLOB_EXPRESSION)
      set(ARGGEN_GLOB_EXPRESSION "*")
    endif()

    list(TRANSFORM ARGGEN_GLOB_EXPRESSION PREPEND "${ARGGEN_SOURCE_DIR}/")

    # Fetch file that are going to be turned into properties
    file(GLOB RES_FILES ${ARGGEN_GLOB_EXPRESSION})

    set(OUT_CONTENT "")
    # Write Header
    string(APPEND OUT_CONTENT
      "// File auto generated with CMake qaterial_generate_icons_class.\n"
      "// Everything written here will be lost.\n\n"
      "#ifndef __QATERIAL_ICONS_HPP__\n"
      "#define __QATERIAL_ICONS_HPP__\n\n"
      "#include <Qaterial/Details/Export.hpp>\n"
      "#include <Qaterial/Details/Property.hpp>\n\n"
      "#include <QtCore/QObject>\n\n"
      "namespace qaterial {\n\n"
      "class QATERIAL_API_ Icons : public QObject\n"
      "{\n"
      "    Q_OBJECT\n"
      "    QATERIAL_SINGLETON_IMPL(Icons, icons, Icons);\n\n"
      "public:\n"
      "    Icons(QObject* parent = nullptr) : QObject(parent) {}\n\n"
      )
    set(QRC_PATH "qrc:/${ARGGEN_PREFIX}")

    foreach(RES_FILE ${RES_FILES})
      get_filename_component(FILENAME_WE ${RES_FILE} NAME_WE)
      get_filename_component(FILENAME ${RES_FILE} NAME)
      get_filename_component(FILENAME_EXT ${RES_FILE} LAST_EXT)

      if(NOT ${FILENAME_EXT} STREQUAL ".qrc")

        set(PROPERTY_NAME_LIST ${FILENAME_WE})
        # Create a list
        string(REGEX REPLACE "[_ -]" ";" PROPERTY_NAME_LIST ${PROPERTY_NAME_LIST})

        set(PROPERTY_NAME "")
        set(PROPERTY_NAME_U "")

        set(PROPERTY_WORD_INDEX 0)
        foreach(PROPERTY_WORD ${PROPERTY_NAME_LIST})
          if(PROPERTY_WORD_INDEX EQUAL 0)
            string(SUBSTRING ${PROPERTY_WORD} 0 1 FIRST_LETTER)
            string(TOLOWER ${FIRST_LETTER} FIRST_LETTER)
            string(REGEX REPLACE "^.(.*)" "${FIRST_LETTER}\\1" PROPERTY_WORD "${PROPERTY_WORD}")

            string(TOUPPER ${FIRST_LETTER} FIRST_LETTER)
            string(REGEX REPLACE "^.(.*)" "${FIRST_LETTER}\\1" PROPERTY_WORD_U "${PROPERTY_WORD}")
          else()
            string(SUBSTRING ${PROPERTY_WORD} 0 1 FIRST_LETTER)
            string(TOUPPER ${FIRST_LETTER} FIRST_LETTER)
            string(REGEX REPLACE "^.(.*)" "${FIRST_LETTER}\\1" PROPERTY_WORD "${PROPERTY_WORD}")

            string(TOUPPER ${FIRST_LETTER} FIRST_LETTER)
            string(REGEX REPLACE "^.(.*)" "${FIRST_LETTER}\\1" PROPERTY_WORD_U "${PROPERTY_WORD}")
          endif()
          set(PROPERTY_NAME "${PROPERTY_NAME}${PROPERTY_WORD}")
          set(PROPERTY_NAME_U "${PROPERTY_NAME_U}${PROPERTY_WORD_U}")
          math(EXPR PROPERTY_WORD_INDEX "${PROPERTY_WORD_INDEX}+1")
        endforeach()

        set(FORBIDDEN_PROPERTY_WORDS id index model modelData console do if in for let new try var case else enum eval null this true void with await break catch class const false super throw while yield delete export import public return static switch typeof default extends finally package private continue debugger function arguments interface protected implements instanceof linux)

        if (${PROPERTY_NAME} IN_LIST FORBIDDEN_PROPERTY_WORDS)
          set(PROPERTY_NAME ${PROPERTY_NAME}_)
        endif()

        string(APPEND OUT_CONTENT
          "    "
          "QATERIAL_PROPERTY_CONST_D(QString, ${PROPERTY_NAME}, ${PROPERTY_NAME_U}, "
          "\"${QRC_PATH}/${FILENAME}\")\;\n")
      endif()
    endforeach()

    string(APPEND OUT_CONTENT
      "}\;\n\n"
      "}\n\n"
      "#endif"
    )

    # Write file to temp then copy to original if there are diff
    file(WRITE ${OUT_FILENAME_ABS}.temp ${OUT_CONTENT})
    execute_process(COMMAND ${CMAKE_COMMAND} -E copy_if_different ${OUT_FILENAME_ABS}.temp ${OUT_FILENAME_ABS})
    file(REMOVE ${OUT_FILENAME_ABS}.temp)

    set(OUT_CONTENT_CPP "")
    string(APPEND OUT_CONTENT_CPP
      "#include <Qaterial/Display/Icons.hpp>\n"
      "#include \"moc_Icons.cpp\"\n"
      "\n"
      "void __Qaterial_registerIconsSingleton()\n"
      "{\n"
      "    qaterial::Icons::registerSingleton()\;\n"
      "}\n"
    )

    file(WRITE ${OUT_FILENAME_ABS_CPP}.temp ${OUT_CONTENT_CPP})
    execute_process(COMMAND ${CMAKE_COMMAND} -E copy_if_different ${OUT_FILENAME_ABS_CPP}.temp ${OUT_FILENAME_ABS_CPP})
    file(REMOVE ${OUT_FILENAME_ABS_CPP}.temp)

  else()
    message(STATUS "${OUT_FILENAME_ABS} already generated, skip generation for faster cmake.")
  endif() # EXISTS OUT_FILENAME_ABS

endfunction()

function(qaterial_generate_icons_class OUTPUT_FILE_HPP OUTPUT_FILE_CPP)

  if(QATERIAL_ENABLE_ICONS)

    # Download svgs icons
    include(${PROJECT_SOURCE_DIR}/cmake/FetchMaterialDesignIcons.cmake)

    message(STATUS "Generate Qaterial/Icons.hpp")
    _qaterial_generate_icons_class(QATERIAL_ICONS_HPP QATERIAL_ICONS_CPP
      SOURCE_DIR ${MATERIALDESIGNICONS_ICONS_DIR}
      NAME ${OUTPUT_FILE_HPP}
      NAME_CPP ${OUTPUT_FILE_CPP}
      CLASS_NAME "Icons"
      PREFIX "Qaterial/Icons"
      GLOB_EXPRESSION ${QATERIAL_ICONS})

  else()

    # Generate fake Qaterial.Impl.Icons.Icons.qml
    message(STATUS "Generate Fake ${OUTPUT_FILE}")
    file(WRITE ${OUTPUT_FILE}
      "// Dummy file generated with CMake to mock the absence of Mdi icons.\n"
      "// Everything written here will be lost.\n\n"
      "#ifndef __QATERIAL_ICONS_HPP__\n"
      "#define __QATERIAL_ICONS_HPP__\n\n"
      "#include <Qaterial/Details/Export.hpp>\n"
      "#include <Qaterial/Details/Property.hpp>\n\n"
      "#include <QtCore/QObject>\n\n"
      "namespace qaterial {\n\n"
      "class QATERIAL_API_ Icons : public QObject\n"
      "{\n"
      "    Q_OBJECT\n"
      "    QATERIAL_SINGLETON_IMPL(Icons, icons, Icons);\n\n"
      "public:\n"
      "    Icons(QObject* parent = nullptr) : QObject(parent) {}\n\n"
      "};\n\n"
      "}\n\n"
      "#endif"
    )

  endif()

endfunction()
