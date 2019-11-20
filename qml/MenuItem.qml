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

T.MenuItem
{
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    property bool drawline: MaterialStyle.debug.drawDebugButton

    width: parent.width

    DebugRectangle
    {
        anchors.fill: parent
        border.color: "pink"
        visible: control.drawline
    }

    display: AbstractButton.TextBesideIcon

    topInset: MaterialStyle.menuItem.topInset
    bottomInset: MaterialStyle.menuItem.bottomInset
    leftInset: MaterialStyle.menuItem.leftInset
    rightInset: MaterialStyle.menuItem.rightInset

    leftPadding: (icon.source != "" && !mirrored || text == "" ? MaterialStyle.menuItem.iconPadding : MaterialStyle.menuItem.padding) + leftInset
    rightPadding: (icon.source != "" && mirrored || text == "" ? MaterialStyle.menuItem.iconPadding : MaterialStyle.menuItem.padding) + rightInset
    topPadding: 0
    bottomPadding: 0
    spacing: MaterialStyle.menuItem.spacing

    property bool outlined: false

    property color foregroundColor: enabled ? (colorReversed ? MaterialStyle.primaryTextColorReversed() : MaterialStyle.primaryTextColor()) :
                                    (colorReversed ? MaterialStyle.hintTextColorReversed() : MaterialStyle.hintTextColor())

    property color backgroundColor: "transparent"

    property color rippleColor: MaterialStyle.rippleColor(onPrimary ? MaterialStyle.RippleBackground.Primary : MaterialStyle.RippleBackground.Background)

    property bool onPrimary: false
    property bool colorReversed: onPrimary && MaterialStyle.shouldReverseForegroundOnPrimary

    property double radius: MaterialStyle.menuItem.cornerRadius

    icon.width: MaterialStyle.menuItem.iconWidth
    icon.height: MaterialStyle.menuItem.iconWidth
    icon.color: foregroundColor

    property bool clipRipple: true
    property bool forceRipple: false
    property bool accentRipple: false

    indicator: Label
    {
        x: control.mirrored ? control.leftPadding : control.width - width - control.rightPadding
        y: control.topPadding + (control.availableHeight - height) / 2
        //width: control.icon.width
        //height: control.icon.height
        width: MaterialStyle.menuItem.shortcutImplicitWidth
        text: control.action && control.action.shortcut ? control.action.shortcut : ""
        visible: control.action && control.action.shortcut != ""
        horizontalAlignment: control.mirrored ? Qt.AlignRight : Qt.AlignLeft
        textType: MaterialStyle.TextType.MenuHint
        onPrimary: control.onPrimary
        colorReversed: control.colorReversed

        DebugRectangle
        {
            anchors.fill: parent
            border.color: "violet"
            visible: control.drawline
        }
    } // Label

    arrow: ColorIcon
    {
        x: control.mirrored ? control.padding : control.width - width - control.padding
        y: control.topPadding + (control.availableHeight - height) / 2

        visible: control.subMenu
        mirror: control.mirrored
        color: control.foregroundColor
        source: "qrc:/Qaterial/Images/menu-right.svg"
    } // ColorIcon

    readonly property var checkedIcon: QtObject
    {
        readonly property double width: MaterialStyle.menuItem.iconWidth
        readonly property double height: MaterialStyle.menuItem.iconWidth
        readonly property color color: foregroundColor
        readonly property url source: "qrc:/Qaterial/Images/check.svg"
    }

    contentItem: IconLabel
    {
        id: _iconLabel

        readonly property real arrowPadding: control.subMenu && control.arrow ? control.arrow.width + control.spacing : 0
        readonly property real indicatorPadding: control.indicator && control.indicator.visible ? control.indicator.width + control.spacing : 0
        anchors.leftMargin: control.mirrored ? indicatorPadding + arrowPadding : 0
        anchors.rightMargin: !control.mirrored ? indicatorPadding + arrowPadding : 0

        alwaysRenderIcon: true

        alignment: Qt.AlignLeft
        elide: Text.ElideRight

        spacing: control.spacing
        display: control.display
        textType: MaterialStyle.TextType.Menu
        icon: control.checkable && checked ? control.checkedIcon : control.icon
        text: control.text
        color: control.foregroundColor

    } // IconLabel

    property double backgroundImplicitWidth: MaterialStyle.menuItem.minWidth
    property double backgroundImplicitHeight: MaterialStyle.menuItem.minHeight

    background: Rectangle
    {
        DebugRectangle
        {
            anchors.fill: parent
            border.color: "aquamarine"
            visible: control.drawline
        } // DebugRectangle

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
