/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12

import Qaterial 1.0

T.ToolBar
{
    id: control

    property double elevation: Style.toolbar.elevation

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    spacing: 16

    property color backgroundColor: Style.primaryColor

    background: Rectangle
    {
        implicitHeight: Style.toolbar.implicitHeight
        color: control.backgroundColor

        layer.enabled: control.elevation > 0
        layer.effect: ElevationEffect
        {
            elevation: control.elevation
            fullWidth: true
        } // ElevationEffect
    } // Rectangle
} // ToolBar
