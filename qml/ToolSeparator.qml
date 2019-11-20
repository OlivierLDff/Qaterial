/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12

import Qaterial 1.0

T.ToolSeparator
{
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    horizontalPadding: vertical ? Style.toolButton.separatorLargePadding : Style.toolButton.separatorSmallPadding
    verticalPadding: vertical ? Style.toolButton.separatorSmallPadding : Style.toolButton.separatorLargePadding

    property bool highlighted: false

    property bool onPrimary: false
    property bool colorReversed: onPrimary && Style.shouldReverseForegroundOnPrimary

    property color foregroundColor: !enabled ? (colorReversed ? Style.disabledDividersColorReversed() : Style.disabledDividersColor()) :
                    highlighted && accentColorAuthorized ? Style.accentColor :
                    colorReversed ? Style.dividersColorReversed() : Style.dividersColor()

    property bool drawline: Style.debug.drawDebugButton

    DebugRectangle
    {
        anchors.fill: parent
        border.color: "pink"
        visible: control.drawline
    }

    contentItem: Rectangle
    {
        implicitWidth: vertical ? 1 : Style.toolButton.separatorImplicitWidth
        implicitHeight: vertical ? Style.toolButton.separatorImplicitWidth : 1
        color: control.foregroundColor
    } // Rectangle
} // ToolSeparator
