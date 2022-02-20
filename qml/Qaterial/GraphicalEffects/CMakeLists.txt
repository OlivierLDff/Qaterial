cmake_minimum_required(VERSION 3.14)
project(GraphicalEffects)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(qtgraphicaleffectsshaders_resource_files
    "shaders_ng/brightnesscontrast.frag.qsb"
    "shaders_ng/colorize.frag.qsb"
    "shaders_ng/coloroverlay.frag.qsb"
    "shaders_ng/conicalgradient_mask.frag.qsb"
    "shaders_ng/conicalgradient_nomask.frag.qsb"
    "shaders_ng/desaturate.frag.qsb"
    "shaders_ng/displace.frag.qsb"
    "shaders_ng/fastblur.frag.qsb"
    "shaders_ng/fastblur_internal.frag.qsb"
    "shaders_ng/fastblur_internal.vert.qsb"
    "shaders_ng/fastglow.frag.qsb"
    "shaders_ng/gammaadjust.frag.qsb"
    "shaders_ng/huesaturation.frag.qsb"
    "shaders_ng/leveladjust.frag.qsb"
    "shaders_ng/lineargradient.vert.qsb"
    "shaders_ng/lineargradient_mask.frag.qsb"
    "shaders_ng/lineargradient_nomask.frag.qsb"
    "shaders_ng/opacitymask.frag.qsb"
    "shaders_ng/opacitymask_invert.frag.qsb"
    "shaders_ng/radialgradient.vert.qsb"
    "shaders_ng/radialgradient_mask.frag.qsb"
    "shaders_ng/radialgradient_nomask.frag.qsb"
    "shaders_ng/rectangularglow.frag.qsb"
    "shaders_ng/thresholdmask.frag.qsb"
    )

set(qml_files
    "BrightnessContrast.qml"
    "ColorOverlay.qml"
    "Colorize.qml"
    "ConicalGradient.qml"
    "Desaturate.qml"
    "Displace.qml"
    "DropShadow.qml"
    "FastBlur.qml"
    "GammaAdjust.qml"
    "Glow.qml"
    "HueSaturation.qml"
    "LevelAdjust.qml"
    "LinearGradient.qml"
    "OpacityMask.qml"
    "RadialGradient.qml"
    "RectangularGlow.qml"
    "ThresholdMask.qml"
    "FastGlow.qml"
    )

find_package(Qt6 6.2 COMPONENTS Core Qml Quick REQUIRED)
qt_add_library(graphicaleffects STATIC)
qt_add_qml_module(graphicaleffects
    URI
        "GraphicalEffects"
    VERSION
        1.0
    RESOURCE_PREFIX
        ""
    SOURCES
        plugin.cpp
        qgfxsourceproxy.cpp
        qgfxsourceproxy_p.h
    QML_FILES
        ${qml_files}
    RESOURCES
        ${qtgraphicaleffectsshaders_resource_files}
    DEPENDENCIES
        QtQuick.Window/auto
    PLUGIN_TARGET
           "graphicaleffects"
       CLASS_NAME
           "GraphicalEffectsPlugin"
    NO_GENERATE_PLUGIN_SOURCE
    NO_PLUGIN_OPTIONAL
    )

target_include_directories(graphicaleffects PRIVATE ${Qt6Quick_PRIVATE_INCLUDE_DIRS})
target_link_libraries(graphicaleffects PRIVATE Qt::Core Qt::Gui Qt::Qml Qt::Quick)
add_library(Qt::GraphicalEffects ALIAS graphicaleffects)
