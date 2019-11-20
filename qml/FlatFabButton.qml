/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Controls 2.12

import QtGraphicalEffects 1.12

// Qaterial
import Qaterial 1.0

FabButton
{
    id: control
    flat: true
    elevation: 0
    highlighted: checked
    type: MaterialStyle.FabType.Default

    readonly property double __inset: rippleClip ? MaterialStyle.fab.flatInset : MaterialStyle.fab.flatInsetNoClip

    topInset:       __inset
    bottomInset:    __inset
    leftInset:      __inset
    rightInset:     __inset

    backgroundColor: !enabled ? "transparent" :
        highlighted ?  MaterialStyle.buttonAccentColor : MaterialStyle.disabledDividersColor()
    property color borderColor: "transparent"
    property bool outlined: false

    foregroundColor: !enabled ? MaterialStyle.disabledTextColor() :
        highlighted ? (MaterialStyle.shouldReverseForegroundOnAccent ? MaterialStyle.primaryTextColorReversed() : MaterialStyle.primaryTextColor()) :
        MaterialStyle.theme === MaterialStyle.Theme.Light ? MaterialStyle.primaryTextColor() : MaterialStyle.secondaryTextColor()
    enabledScale: false

    property bool rippleClip: true

    property double backgroundImplicitWidth: type === MaterialStyle.FabType.Extended ? MaterialStyle.fab.minWidthExtended :
            type === MaterialStyle.FabType.Mini ? MaterialStyle.fab.minWidthMini : MaterialStyle.fab.minWidth
    property double backgroundImplicitHeight: type === MaterialStyle.FabType.Extended ? MaterialStyle.fab.minHeightExtended :
            type === MaterialStyle.FabType.Mini ? MaterialStyle.fab.minWidthMini : MaterialStyle.fab.minWidth
    property double backgroundScale: 1.0

    background: Rectangle
    {
        implicitWidth: control.backgroundImplicitWidth
        implicitHeight: control.backgroundImplicitHeight
        radius: control.radius
        color: control.backgroundColor
        scale: control.backgroundScale

        border.width: control.outlined ? 1 : 0
        border.color: control.borderColor

        Behavior on implicitWidth { NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 } }
        Behavior on implicitHeight { NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 } }

        DebugRectangle
        {
            anchors.fill: parent
            border.color: "aquamarine"
            visible: control.drawline
        }

        Ripple
        {
            id: ripple
            property bool isActive: control.down || control.visualFocus || control.hovered
            width: rippleClip ? parent.width : parent.implicitWidth
            height: rippleClip ? parent.height : parent.implicitHeight
            anchors.centerIn: parent
            pressed: control.pressed
            anchor: control
            active: isActive
            color: control.rippleColor
            layer.enabled: control.rippleClip
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
} // FabButton
