/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Templates 2.12 as T

// Qaterial
import Qaterial 1.0

T.Frame
{
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    horizontalPadding: Style.card.horizontalPadding
    verticalPadding: Style.card.verticalPadding

    property bool onPrimary: false
    property bool colorReversed: onPrimary && Style.shouldReverseForegroundOnPrimary

    property color color: onPrimary ? Style.primaryColor : Style.backgroundColor
    property color borderColor: enabled ? Style.dividersColor() : Style.disabledDividersColor()
    property alias radius: _rect.radius

    property double elevation

    background: Rectangle
    {
        id: _rect
        implicitWidth: 200
        radius: Style.card.radius
        color: control.elevation > 0 ? control.color : "transparent"
        border.color: control.borderColor
        border.width: 1

        layer.enabled: control.enabled && control.elevation > 0
        layer.effect: ElevationEffect
        {
            elevation: control.elevation
        }
    } // Rectangle
} // Frame
