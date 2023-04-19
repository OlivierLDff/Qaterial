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

include(${PROJECT_SOURCE_DIR}/cmake/FetchGoogleFontCMake.cmake)

set(QATERIAL_FONT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/Generated/Qaterial)

# Make sure directory is created even if no font are created
file(MAKE_DIRECTORY ${QATERIAL_FONT_DIRECTORY})

set(GOOGLEFONTS_REPOSITORY "https://github.com/OlivierLDff/fonts")
set(GOOGLEFONTS_TAG "0cdadf80ac5f29f10a73c29ce1f4f1ca75ffb392")

if(QATERIAL_ENABLE_ROBOTO)
  message(STATUS "Fetch Roboto Medium/Regular")
  fetch_google_font(
    URL ${GOOGLEFONTS_REPOSITORY}
    TAG ${GOOGLEFONTS_TAG}
    FAMILY "Roboto"
    STYLES Medium Regular
    OUTPUT_DIR ${QATERIAL_FONT_DIRECTORY}/Fonts/Roboto
    VERBOSE
  )
endif()

if(QATERIAL_ENABLE_ROBOTOMONO)
  message(STATUS "Fetch RobotoMono Regular")
  fetch_google_font(
    URL ${GOOGLEFONTS_REPOSITORY}
    TAG ${GOOGLEFONTS_TAG}
    FAMILY "RobotoMono"
    STYLES Regular
    OUTPUT_DIR ${QATERIAL_FONT_DIRECTORY}/Fonts/RobotoMono
    VERBOSE
  )
endif()

if(QATERIAL_ENABLE_LATO)
  message(STATUS "Fetch Lato Regular")
  fetch_google_font(
    URL ${GOOGLEFONTS_REPOSITORY}
    TAG ${GOOGLEFONTS_TAG}
    FAMILY "Lato"
    STYLES Regular
    OUTPUT_DIR ${QATERIAL_FONT_DIRECTORY}/Fonts/Lato
    LICENSE "ofl"
    VERBOSE
  )
endif()

message(STATUS "Generate QaterialFonts.qrc")

# Always generate a qrc, even if no font exist
qt_generate_qrc(QATERIAL_FONTS_QML_QRC
  SOURCE_DIR ${QATERIAL_FONT_DIRECTORY}
  DEST_DIR ${QATERIAL_FONT_DIRECTORY}
  NAME QaterialFonts.qrc
  PREFIX "Qaterial"
  GLOB_EXPRESSION "*.ttf"
  RECURSE)

add_library(${QATERIAL_TARGET}Fonts STATIC ${QATERIAL_FONTS_QML_QRC})
add_library(${QATERIAL_TARGET}::Fonts ALIAS ${QATERIAL_TARGET}Fonts)
set_target_properties(${QATERIAL_TARGET}Fonts PROPERTIES AUTORCC TRUE)

target_link_libraries(${QATERIAL_TARGET}Fonts PRIVATE
  Qt::Core
  Qt::Gui
  Qt::Svg
  Qt::Xml
  Qt::Qml
)

if(QATERIAL_FOLDER_PREFIX)
  set_target_properties(${QATERIAL_TARGET}Fonts PROPERTIES FOLDER ${QATERIAL_FOLDER_PREFIX})
endif()

if(QATERIAL_ENABLE_INSTALL)
  include(GNUInstallDirs)
  install(TARGETS ${QATERIAL_TARGET}Fonts
    EXPORT ${QATERIAL_TARGET}FontsTargets
  )

  export(EXPORT ${QATERIAL_TARGET}FontsTargets
    FILE "${CMAKE_CURRENT_BINARY_DIR}/${QATERIAL_TARGET}/${QATERIAL_TARGET}FontsTargets.cmake"
  )

  set(ConfigPackageLocation lib/cmake/${QATERIAL_TARGET})
  install(EXPORT ${QATERIAL_TARGET}FontsTargets
    FILE
    ${QATERIAL_TARGET}FontsTargets.cmake
    DESTINATION
    ${ConfigPackageLocation}
  )
endif()
