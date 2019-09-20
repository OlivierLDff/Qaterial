/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Templates 2.12 as T

import QQuickMaterialHelper.Style 1.12
import QQuickMaterialHelper.Core 1.12

T.Pane
{
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    padding: MaterialStyle.card.horizontalPadding

    property bool onPrimary: false
    property bool colorReversed: onPrimary && MaterialStyle.shouldReverseForegroundOnPrimary

    property double elevation: 0
    property color color: control.onPrimary ? MaterialStyle.primaryColor : MaterialStyle.backgroundColor
    property double radius: 0

    background: Rectangle
    {
        id: _back
        color: control.color
        radius: control.radius
        layer.enabled: control.enabled && control.elevation > 0
        layer.effect: ElevationEffect
        {
            elevation: control.elevation
        } // ElevationEffect
    } // Rectangle
} // Pane
