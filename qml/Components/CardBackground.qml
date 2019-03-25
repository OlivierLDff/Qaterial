/** 
 * Copyright (C) Olivier Le Doeuff 2019 
 * Contact: olivier.ldff@gmail.com 
 */

import QtQuick 2.12
import QtQuick.Controls 2.12

import QQuickMaterialHelper.Style 1.12
import QQuickMaterialHelper.Core 1.12
import QQuickMaterialHelper.Components 1.12

Rectangle 
{
    id: control
    property bool enabled: true
    property bool outlined: false
    property bool isActive: false
    property double elevation: isActive ? MaterialStyle.card.activeElevation : (outlined ? 0 : MaterialStyle.card.defaultElevation)

    property bool onPrimary: false
    property bool colorReversed: onPrimary && MaterialStyle.shouldReverseForegroundOnPrimary

    color: onPrimary ? MaterialStyle.primaryColor : MaterialStyle.backgroundColor
    property color borderColor: enabled ? MaterialStyle.dividersColor() : MaterialStyle.disabledDividersColor()
    radius: MaterialStyle.card.radius 
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