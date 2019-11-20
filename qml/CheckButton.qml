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


T.CheckBox
{
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding + implicitIndicatorWidth)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)

    spacing: Style.checkButton.spacing
    horizontalPadding: Style.checkButton.horizontalPadding
    verticalPadding: Style.checkButton.verticalPadding

    property bool onPrimary: false
    property bool colorReversed: onPrimary && Style.shouldReverseForegroundOnPrimary

    property bool drawline: Style.debug.drawDebugButton

    property alias elide: _label.elide
    property alias textType: _label.textType

    DebugRectangle
    {
        anchors.fill: parent
        border.color: "pink"
        visible: control.drawline
    }

    indicator: CheckIndicator
    {
        x: text ? (control.mirrored ? control.width - width - control.rightPadding : control.leftPadding) : control.leftPadding + (control.availableWidth - width) / 2
        y: control.topPadding + (control.availableHeight - height) / 2
        control: control

        Ripple
        {
            x: (parent.width - width) / 2
            y: (parent.height - height) / 2
            width: Style.switchButton.rippleWidth
            height: Style.switchButton.rippleWidth

            z: -1
            anchor: control
            pressed: control.pressed
            active: control.down || control.visualFocus || control.hovered
            color: Style.rippleColor(control.checked ? Style.RippleBackground.AccentLight : Style.RippleBackground.Background)
        } // Ripple

        DebugRectangle
        {
            anchors.fill: parent
            border.color: "red"
            visible: control.drawline
        } // DebugRectangle
    } // CheckIndicator

    contentItem: Label
    {
        id: _label
        leftPadding: control.indicator && !control.mirrored ? control.indicator.width + control.spacing : 0
        rightPadding: control.indicator && control.mirrored ? control.indicator.width + control.spacing : 0

        onPrimary: control.onPrimary
        colorReversed: control.colorReversed

        text: control.text
        enabled: control.enabled
        elide: !control.mirrored ? Text.ElideRight : Text.ElideLeft
        verticalAlignment: Text.AlignVCenter

        DebugRectangle
        {
            anchors.fill: parent
            border.color: "green"
            visible: control.drawline
        } // DebugRectangle
    } // Label
} // CheckBox
