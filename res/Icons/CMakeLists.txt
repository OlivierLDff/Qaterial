# No matter if QATERIAL_ENABLE_ICONS is ON or OFF, always generate something.
# From Qaterial point of view nothing change

file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/Generated/qmldir
  "module Qaterial.Impl.Icons\n"
  "Icons 1.0 Icons.qml\n"
)

if(QATERIAL_ENABLE_ICONS)

  # Download svgs icons
  include(${PROJECT_SOURCE_DIR}/cmake/FetchMaterialDesignIcons.cmake)

  # Generate qrc to embed svgs files
  qt_generate_qrc(QATERIAL_QML_ICONS_QRC
    SOURCE_DIR ${MATERIALDESIGNICONS_ICONS_DIR}
    NAME QaterialIcons.qrc
    PREFIX "Qaterial/Icons"
    GLOB_EXPRESSION ${QATERIAL_ICONS})

  # Generate Qaterial.Impl.Icons.Icons.qml
  qt_generate_qrc_alias_qt_object(QATERIAL_ICONS_QML
    SOURCE_DIR ${MATERIALDESIGNICONS_ICONS_DIR}
    NAME "${CMAKE_CURRENT_BINARY_DIR}/Generated/Icons.qml"
    PREFIX "Qaterial/Icons"
    GLOB_EXPRESSION ${QATERIAL_ICONS})

else()

  # Generate fake qrc to embed svgs files
  file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/Generated/QaterialIcons.qrc
   "<!-- File auto with CMake to mock the absence of Mdi icons. Everything written here will be lost. -->\n"
    "<RCC>\n"
    "  <qresource prefix=\"/Qaterial/Icons\">\n"
    "  </qresource>\n"
    "</RCC>\n"
  )

  # Generate fake Qaterial.Impl.Icons.Icons.qml
  file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/Generated/Icons.qml
    "// Dummy file generated with CMake to mock the absence of Mdi icons.\n"
    "// Everything written here will be lost.\n\n"
    "import QtQml 2.0\n\n"
    "QtObject\n"
    "{\n"
    "}\n"
  )

endif()

qt_generate_qrc(QATERIAL_QML_ICONS_ALIAS_QRC
  SOURCE_DIR "${CMAKE_CURRENT_BINARY_DIR}/Generated"
  NAME QaterialIconsImpl.qrc
  PREFIX "Qaterial/Impl/Icons"
  GLOB_EXPRESSION "*.qml;qmldir;")

add_library(${QATERIAL_TARGET}Icons STATIC ${QATERIAL_QML_ICONS_QRC} ${QATERIAL_QML_ICONS_ALIAS_QRC})
set_target_properties(${QATERIAL_TARGET}Icons PROPERTIES AUTORCC TRUE)

target_link_libraries(${QATERIAL_TARGET}Icons PRIVATE
  Qt5::Core
  Qt5::Gui
  Qt5::Svg
  Qt5::Xml
  Qt5::Qml
)

if(QATERIAL_FOLDER_PREFIX)
  set_target_properties(${QATERIAL_TARGET}Icons PROPERTIES FOLDER ${QATERIAL_FOLDER_PREFIX})
endif()
