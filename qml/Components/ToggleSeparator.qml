/** 
 * Copyright (C) Olivier Le Doeuff 2019 
 * Contact: olivier.ldff@gmail.com 
 */

import QtQuick 2.12
import QtQuick.Controls 2.12

import QQuickMaterialHelper.Style 1.12
import QQuickMaterialHelper.Core 1.12

ToolSeparator 
{
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    horizontalPadding: vertical ? MaterialStyle.toolButton.separatorLargePadding : MaterialStyle.toolButton.separatorSmallPadding
    verticalPadding: vertical ? MaterialStyle.toolButton.separatorSmallPadding : MaterialStyle.toolButton.separatorLargePadding

    property bool highlighted: false

    property bool onPrimary: false
    property bool colorReversed: onPrimary && MaterialStyle.shouldReverseForegroundOnPrimary

    property color foregroundColor: "transparent"

    property bool drawline: MaterialStyle.debug.drawDebugButton

    DebugRectangle
    {
        anchors.fill: parent
        border.color: "pink"
        visible: control.drawline
    }

    contentItem: Rectangle 
    {
        implicitWidth: vertical ? 1 : MaterialStyle.toolButton.separatorImplicitWidth
        implicitHeight: vertical ? MaterialStyle.toolButton.separatorImplicitWidth : 1
        color: control.foregroundColor
    } // Rectangle
} // ToolSeparator
