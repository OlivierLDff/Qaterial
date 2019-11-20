/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12

// Qaterial
import Qaterial 1.0

T.MenuSeparator
{
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    verticalPadding: Style.menu.separatorHSmallPadding
    rightPadding: !mirrored ? Style.menu.separatorWSmallPadding : Style.menu.separatorWLargePadding
    leftPadding: mirrored ? Style.menu.separatorWSmallPadding : Style.menu.separatorWLargePadding

    property bool highlighted: false

    property bool onPrimary: false
    property bool colorReversed: onPrimary && Style.shouldReverseForegroundOnPrimary
    property bool accentColorAuthorized: onPrimary && Style.preferAccentOnPrimary

    property color foregroundColor: !enabled ? (colorReversed ? Style.disabledDividersColorReversed() : Style.disabledDividersColor()) :
                    highlighted && accentColorAuthorized ? Style.accentColor :
                    colorReversed ? Style.dividersColorReversed() : Style.dividersColor()

    property bool drawline: Style.debug.drawDebugButton

    property double separatorImplicitWidth: Style.menu.separatorImplicitWidth

    DebugRectangle
    {
        anchors.fill: parent
        border.color: "pink"
        visible: control.drawline
    } // DebugRectangle

    contentItem: Rectangle
    {
        implicitWidth: control.separatorImplicitWidth
        implicitHeight: 1
        color: control.foregroundColor

        DebugRectangle
        {
            anchors.fill: parent
            border.color: "red"
            visible: control.drawline
        } // DebugRectangle

    } // Rectangle
} // MenuSeparator
