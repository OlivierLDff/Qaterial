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

    property bool drawline: Style.debug.drawDebugButton

    width: parent ? parent.width : 100

    DebugRectangle
    {
        anchors.fill: parent
        border.color: "pink"
        visible: control.drawline
    }

    display: AbstractButton.TextBesideIcon

    topInset: Style.menuItem.topInset
    bottomInset: Style.menuItem.bottomInset
    leftInset: Style.menuItem.leftInset
    rightInset: Style.menuItem.rightInset

    leftPadding: (icon.source != "" && !mirrored || text == "" ? Style.menuItem.iconPadding : Style.menuItem.padding) + leftInset
    rightPadding: (icon.source != "" && mirrored || text == "" ? Style.menuItem.iconPadding : Style.menuItem.padding) + rightInset
    topPadding: 0
    bottomPadding: 0
    spacing: Style.menuItem.spacing

    property bool outlined: false

    property color foregroundColor: enabled ? (colorReversed ? Style.primaryTextColorReversed() : Style.primaryTextColor()) :
                                    (colorReversed ? Style.hintTextColorReversed() : Style.hintTextColor())

    property color backgroundColor: "transparent"

    property color rippleColor: Style.rippleColor(onPrimary ? Style.RippleBackground.Primary : Style.RippleBackground.Background)

    property bool onPrimary: false
    property bool colorReversed: onPrimary && Style.shouldReverseForegroundOnPrimary

    property double radius: Style.menuItem.cornerRadius


    readonly property var checkedIcon: QtObject
    {
        readonly property double width: Style.menuItem.iconWidth
        readonly property double height: Style.menuItem.iconWidth
        readonly property color color: foregroundColor
        readonly property url source: "qrc:/Qaterial/Images/check.svg"
    }

    readonly property var radioIcon: QtObject
    {
        readonly property double width: Style.menuItem.iconWidth
        readonly property double height: Style.menuItem.iconWidth
        readonly property color color: foregroundColor
        readonly property url source: control.checked ? "qrc:///Qaterial/Images/radiobox-marked.svg" : "qrc:///Qaterial/Images/radiobox-blank.svg"
    }

    icon.width: Style.menuItem.iconWidth
    icon.height: Style.menuItem.iconWidth
    icon.color: foregroundColor
    icon.source: checkable && checked ? "qrc:/Qaterial/Images/check.svg" : ""

    property bool clipRipple: true
    property bool forceRipple: false
    property bool accentRipple: false

    indicator: Label
    {
        x: control.mirrored ? control.leftPadding : control.width - width - control.rightPadding
        y: control.topPadding + (control.availableHeight - height) / 2
        //width: control.icon.width
        //height: control.icon.height
        width: Style.menuItem.shortcutImplicitWidth
        text: control.action && control.action.shortcut ? control.action.shortcut : ""
        visible: control.action && control.action.shortcut != ""
        horizontalAlignment: control.mirrored ? Qt.AlignRight : Qt.AlignLeft
        textType: Style.TextType.MenuHint
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
        textType: Style.TextType.Menu
        icon: control.icon
        text: control.text
        color: control.foregroundColor

    } // IconLabel

    property double backgroundImplicitWidth: Style.menuItem.minWidth
    property double backgroundImplicitHeight: Style.menuItem.minHeight

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
