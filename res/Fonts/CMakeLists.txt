include(${PROJECT_SOURCE_DIR}/cmake/FetchGoogleFontCMake.cmake)

set(QATERIAL_FONT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/Generated/Qaterial)

# Make sure directory is created even if no font are created
file(MAKE_DIRECTORY ${QATERIAL_FONT_DIRECTORY})

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
set_target_properties(${QATERIAL_TARGET}Fonts PROPERTIES AUTORCC TRUE)

target_link_libraries(${QATERIAL_TARGET}Fonts PRIVATE
  Qt5::Core
  Qt5::Gui
  Qt5::Svg
  Qt5::Xml
  Qt5::Qml
)

if(QATERIAL_FOLDER_PREFIX)
  set_target_properties(${QATERIAL_TARGET}Fonts PROPERTIES FOLDER ${QATERIAL_FOLDER_PREFIX})
endif()
