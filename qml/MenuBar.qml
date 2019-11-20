/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Templates 2.12 as T

// Qaterial
import Qaterial 1.0

T.MenuBar
{
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    delegate: MenuBarItem { onPrimary: control.onPrimary; colorReversed: control.colorReversed }

    contentItem: Row
    {
        spacing: control.spacing
        Repeater
        {
            model: control.contentModel
        } // Repeater
    } // Row

    property bool onPrimary: false
    property bool colorReversed: onPrimary && Style.shouldReverseForegroundOnPrimary

    property color backgroundColor: onPrimary ? Style.primaryColor : Style.dialogColor

    background: Rectangle
    {
        implicitHeight: Style.menu.implicitHeight
        color: control.backgroundColor
    }
} // MenuBar
