/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

import QtQuick 2.12

import QQuickMaterialHelper.Style 1.12 as MStyle
import QQuickMaterialHelper.Core 1.12 as MCore

Item
{
    id: root
    implicitWidth: initialSize
    implicitHeight: initialSize

    property real value: 0
    property bool handleHasFocus: false
    property bool handlePressed: false
    property bool handleHovered: false
    readonly property int initialSize: 13

    property color rippleColor: MStyle.MaterialStyle.rippleColorTheme
    property color accentColor: MStyle.MaterialStyle.accentColor

    Rectangle
    {
        id: handleRect
        width: parent.width
        height: parent.height
        radius: width / 2
        color: root.accentColor
        scale: root.handlePressed ? 1.5 : 1

        Behavior on scale {
            NumberAnimation {
                duration: 250
            }
        }
    }

    MCore.Ripple
    {
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        width: 22; height: 22
        pressed: root.handlePressed
        active: root.handlePressed || root.handleHasFocus || root.handleHovered
        color: root.rippleColor
    }
}
