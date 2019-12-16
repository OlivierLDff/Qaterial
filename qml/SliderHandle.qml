/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12

// Qaterial
import Qaterial 1.0

Item
{
    id: root
    implicitWidth: initialSize
    implicitHeight: initialSize

    property bool enabled

    property real value: 0
    property bool handleHasFocus: false
    property bool handlePressed: false
    property bool handleHovered: false
    readonly property int initialSize: 13

    property color rippleColor: Style.rippleColorTheme
    property color accentColor: Style.accentColor
    property color disabledColor: Style.disabledTextColor()

    Rectangle
    {
        id: handleRect
        width: parent.width
        height: parent.height
        radius: width / 2
        color: root.enabled ? root.accentColor : root.disabledColor
        scale: root.handlePressed ? 1.5 : 1

        Behavior on scale {
            NumberAnimation {
                duration: 250
            }
        }
    }

    Ripple
    {
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        width: 22; height: 22
        pressed: root.handlePressed
        active: root.handlePressed || root.handleHasFocus || root.handleHovered
        color: root.rippleColor
    }
}
