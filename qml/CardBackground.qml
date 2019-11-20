/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Controls 2.12

// Qaterial
import Qaterial 1.0

Rectangle
{
    id: control
    property bool enabled: true
    property bool outlined: false
    property bool isActive: false
    property double elevation: isActive ? Style.card.activeElevation : (outlined ? 0 : Style.card.defaultElevation)

    property bool onPrimary: false
    property bool colorReversed: onPrimary && Style.shouldReverseForegroundOnPrimary

    color: onPrimary ? Style.primaryColor : Style.cardColor
    property color borderColor: enabled ? Style.dividersColor() : Style.disabledDividersColor()
    radius: Style.card.radius
    border.width: outlined ? 1 : 0
    border.color: isActive ? "transparent" : borderColor

    Behavior on border.color
    {
        ColorAnimation
        {
            duration: 250
            easing.type: Easing.OutCubic
        } // ColorAnimation
    } // Behavior

    Behavior on elevation
    {
        NumberAnimation
        {
            duration: 250
            easing.type: Easing.OutCubic
        } // ColorAnimation
    } // Behavior

    layer.enabled: control.enabled && control.elevation > 0
    layer.effect: ElevationEffect
    {
        elevation: control.elevation
    } // ElevationEffect
} // Rectangle
