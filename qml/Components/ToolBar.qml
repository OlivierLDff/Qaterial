/** 
 * Copyright (C) Olivier Le Doeuff 2019 
 * Contact: olivier.ldff@gmail.com 
 */

import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12

import QQuickMaterialHelper.Style 1.12
import QQuickMaterialHelper.Core 1.12
import QQuickMaterialHelper.Components 1.12

T.ToolBar 
{
    id: control

    property double elevation: MaterialStyle.toolbar.elevation

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    spacing: 16

    property color backgroundColor: MaterialStyle.primaryColor

    background: Rectangle 
    {
        implicitHeight: MaterialStyle.toolbar.implicitHeight
        color: control.backgroundColor

        layer.enabled: control.elevation > 0
        layer.effect: ElevationEffect 
        {
            elevation: control.elevation
            fullWidth: true
        } // ElevationEffect
    } // Rectangle
} // ToolBar
