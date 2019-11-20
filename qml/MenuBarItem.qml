/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12

import QtGraphicalEffects 1.12

// Qaterial
import Qaterial 1.0

T.MenuBarItem
{
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    property bool drawline: Style.debug.drawDebugButton

    DebugRectangle
    {
        anchors.fill: parent
        border.color: "pink"
        visible: control.drawline
    }

    topInset: Style.menuBarItem.topInset
    bottomInset: Style.menuBarItem.bottomInset
    leftInset: Style.menuBarItem.leftInset
    rightInset: Style.menuBarItem.rightInset

    property alias textType: _iconLabel.textType

    leftPadding: (icon.source != "" && !mirrored || text == "" ? Style.menuBarItem.iconPadding : Style.menuBarItem.padding) + leftInset
    rightPadding: (icon.source != "" && mirrored || text == "" ? Style.menuBarItem.iconPadding : Style.menuBarItem.padding) + rightInset
    topPadding: 0
    bottomPadding: 0
    spacing: Style.menuBarItem.spacing

    property bool outlined: false

    property color foregroundColor: enabled ? (colorReversed ? Style.primaryTextColorReversed() : Style.primaryTextColor()) :
                                    (colorReversed ? Style.hintTextColorReversed() : hintTextColor.primaryTextColor())

    property color backgroundColor: "transparent"

    property color rippleColor: Style.rippleColor(onPrimary ? Style.RippleBackground.Primary : Style.RippleBackground.Background)

    property bool onPrimary: false
    property bool colorReversed: onPrimary && Style.shouldReverseForegroundOnPrimary

    property double radius: Style.menuBarItem.cornerRadius

    icon.width: Style.menuBarItem.iconWidth
    icon.height: Style.menuBarItem.iconWidth
    icon.color: foregroundColor

    property bool clipRipple: true
    property bool forceRipple: false
    property bool accentRipple: false

    contentItem: IconLabel
    {
        id: _iconLabel
        spacing: control.spacing
        display: control.display
        icon: control.icon
        text: control.text
        textType: Style.TextType.Menu
        color: control.foregroundColor
    } // IconLabel

    property double backgroundImplicitWidth: Style.menuBarItem.minWidth
    property double backgroundImplicitHeight: Style.menuBarItem.minHeight

    focusPolicy: Qt.StrongFocus

    background: Rectangle
    {
        DebugRectangle
        {
            anchors.fill: parent
            border.color: "aquamarine"
            visible: control.drawline
        }

        implicitWidth: control.backgroundImplicitWidth
        implicitHeight: control.backgroundImplicitHeight
        radius: control.radius
        color: control.backgroundColor

        Ripple
        {
            id: ripple
            property bool isActive: control.down || control.visualFocus || control.hovered || control.forceRipple
            width: parent.width
            height: parent.height
            anchors.centerIn: parent
            pressed: control.pressed
            anchor: control
            active: isActive
            color: control.rippleColor
            // trick because clipRadius isn't working in ripple private implementation (QTBUG-51894)
            layer.enabled: control.clipRipple
            layer.effect: OpacityMask
            {
                maskSource: Rectangle
                {
                    width: ripple.width
                    height: ripple.height
                    radius: control.radius
                }
            } // OpacityMask
        } // Ripple
    } // Rectangle
}
