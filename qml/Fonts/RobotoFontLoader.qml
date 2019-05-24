/*
 * QML Material - An application framework implementing Material Design.
 *
 * Copyright (C) 2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */


import QtQuick 2.12

Item {
    FontLoader {source: Qt.resolvedUrl("qrc:/QQuickMaterialHelper/fonts/roboto/Roboto-BlackItalic.ttf")}
    FontLoader {source: Qt.resolvedUrl("qrc:/QQuickMaterialHelper/fonts/roboto/Roboto-Black.ttf")}
    FontLoader {source: Qt.resolvedUrl("qrc:/QQuickMaterialHelper/fonts/roboto/Roboto-Bold.ttf")}
    FontLoader {source: Qt.resolvedUrl("qrc:/QQuickMaterialHelper/fonts/roboto/Roboto-BoldItalic.ttf")}
    FontLoader {source: Qt.resolvedUrl("qrc:/QQuickMaterialHelper/fonts/roboto/RobotoCondensed-Bold.ttf")}
    FontLoader {source: Qt.resolvedUrl("qrc:/QQuickMaterialHelper/fonts/roboto/RobotoCondensed-BoldItalic.ttf")}
    FontLoader {source: Qt.resolvedUrl("qrc:/QQuickMaterialHelper/fonts/roboto/Roboto-Medium.ttf")}
    FontLoader {source: Qt.resolvedUrl("qrc:/QQuickMaterialHelper/fonts/roboto/Roboto-MediumItalic.ttf")}
    FontLoader {source: Qt.resolvedUrl("qrc:/QQuickMaterialHelper/fonts/roboto/Roboto-Regular.ttf")}
    FontLoader {source: Qt.resolvedUrl("qrc:/QQuickMaterialHelper/fonts/roboto/RobotoCondensed-Italic.ttf")}
    FontLoader {source: Qt.resolvedUrl("qrc:/QQuickMaterialHelper/fonts/roboto/RobotoCondensed-Light.ttf")}
    FontLoader {source: Qt.resolvedUrl("qrc:/QQuickMaterialHelper/fonts/roboto/RobotoCondensed-LightItalic.ttf")}
    FontLoader {source: Qt.resolvedUrl("qrc:/QQuickMaterialHelper/fonts/roboto/RobotoCondensed-Regular.ttf")}
    FontLoader {source: Qt.resolvedUrl("qrc:/QQuickMaterialHelper/fonts/roboto/Roboto-Italic.ttf")}
    FontLoader {source: Qt.resolvedUrl("qrc:/QQuickMaterialHelper/fonts/roboto/Roboto-Light.ttf")}
    FontLoader {source: Qt.resolvedUrl("qrc:/QQuickMaterialHelper/fonts/roboto/Roboto-LightItalic.ttf")}
    FontLoader {source: Qt.resolvedUrl("qrc:/QQuickMaterialHelper/fonts/roboto/Roboto-Thin.ttf")}
    FontLoader {source: Qt.resolvedUrl("qrc:/QQuickMaterialHelper/fonts/roboto/Roboto-ThinItalic.ttf")}

    Component.onCompleted: console.log("Load Roboto Font")
}
