/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Controls 2.12

// Qaterial
import Qaterial 1.0

Pane
{
    id: control
    padding: 0
    property bool onPrimary: false
    property bool colorReversed: onPrimary && MaterialStyle.shouldReverseForegroundOnPrimary

    radius: MaterialStyle.card.radius

    property color backgroundColor: onPrimary ? MaterialStyle.primaryColor : MaterialStyle.cardColor
    property color borderColor: enabled ? MaterialStyle.dividersColor() : MaterialStyle.disabledDividersColor()
    property bool outlined: false

    property double elevation: isActive ? MaterialStyle.card.activeElevation : (outlined ? 0 : MaterialStyle.card.defaultElevation)

    property bool isActive: (elevationOnHovered && hovered) || pressed || visualFocus

    property string headerText
    property string subHeaderText
    property string supportingText
    property string media
    property string thumbnail

    property bool pressed: false
    property bool elevationOnHovered: false

    background: CardBackground
    {
        id: _cardBackground
        isActive: control.isActive
        onPrimary: control.onPrimary
        enabled: control.enabled
        radius: control.radius
        color: control.backgroundColor
        borderColor: control.borderColor
        outlined: control.outlined
        elevation: control.elevation
    } // Rectangle
}
