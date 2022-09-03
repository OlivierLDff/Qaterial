cmake_minimum_required(VERSION 3.14)
project(GraphicalEffects)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(qtgraphicaleffectsshaders_resource_files
    "shaders_ng/colorize.frag.qsb"
    "shaders_ng/coloroverlay.frag.qsb"
    "shaders_ng/lineargradient.vert.qsb"
    "shaders_ng/lineargradient_mask.frag.qsb"
    "shaders_ng/lineargradient_nomask.frag.qsb"
    "shaders_ng/opacitymask.frag.qsb"
    "shaders_ng/opacitymask_invert.frag.qsb"
    )

set(qml_files
    "ColorOverlay.qml"
    "Colorize.qml"
    "LinearGradient.qml"
    "OpacityMask.qml"
    )

find_package(Qt6 6.2 COMPONENTS Core Qml Quick REQUIRED)
qt_add_library(graphicaleffects STATIC)
qt_add_qml_module(graphicaleffects
    URI
        "GraphicalEffects"
    VERSION
        1.0
    QML_FILES
        ${qml_files}
    RESOURCES
        ${qtgraphicaleffectsshaders_resource_files}
    DEPENDENCIES
        QtQuick.Window/auto
    NO_GENERATE_PLUGIN_SOURCE
    NO_PLUGIN_OPTIONAL
    )

target_include_directories(graphicaleffects PRIVATE ${Qt6Quick_PRIVATE_INCLUDE_DIRS})
target_link_libraries(graphicaleffects PRIVATE Qt::Core Qt::Gui Qt::Qml Qt::Quick)
add_library(Qt::GraphicalEffects ALIAS graphicaleffects)
