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

T.RadioButton
{
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding + implicitIndicatorWidth)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)

    horizontalPadding: MaterialStyle.radioButton.horizontalPadding
    verticalPadding: MaterialStyle.radioButton.verticalPadding
    spacing: MaterialStyle.radioButton.spacing

    property bool onPrimary: false
    property bool colorReversed: onPrimary && MaterialStyle.shouldReverseForegroundOnPrimary

    property bool drawline: MaterialStyle.debug.drawDebugButton

    property alias elide: _label.elide
    property alias textType: _label.textType

    DebugRectangle
    {
        anchors.fill: parent
        border.color: "pink"
        visible: control.drawline
    }

    indicator: RadioIndicator
    {
        x: text ? (control.mirrored ? control.width - width - control.rightPadding : control.leftPadding) : control.leftPadding + (control.availableWidth - width) / 2
        y: control.topPadding + (control.availableHeight - height) / 2
        control: control

        Ripple
        {
            x: (parent.width - width) / 2
            y: (parent.height - height) / 2
            width: MaterialStyle.radioButton.rippleWidth
            height: MaterialStyle.radioButton.rippleWidth

            z: -1
            anchor: control
            pressed: control.pressed
            active: control.down || control.visualFocus || control.hovered
            color: MaterialStyle.rippleColor(control.checked ? MaterialStyle.RippleBackground.AccentLight : MaterialStyle.RippleBackground.Background)
        } // Ripple
        DebugRectangle
        {
            anchors.fill: parent
            border.color: "red"
            visible: control.drawline
        } // DebugRectangle
    } // RadioIndicator

    contentItem: Label
    {
        id: _label
        leftPadding: control.indicator && !control.mirrored ? control.indicator.width + control.spacing : 0
        rightPadding: control.indicator && control.mirrored ? control.indicator.width + control.spacing : 0

        onPrimary: control.onPrimary
        colorReversed: control.colorReversed

        text: control.text
        enabled: control.enabled
        verticalAlignment: Text.AlignVCenter
        elide: !control.mirrored ? Text.ElideRight : Text.ElideLeft

        DebugRectangle
        {
            anchors.fill: parent
            border.color: "green"
            visible: control.drawline
        } // DebugRectangle
    } // Label
} // RadioButton
