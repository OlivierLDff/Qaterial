/** 
 * Copyright (C) Olivier Le Doeuff 2019 
 * Contact: olivier.ldff@gmail.com 
 */

import QtQuick 2.12
import QtQuick.Controls 2.12

import QQuickMaterialHelper.Style 1.12
import QQuickMaterialHelper.Core 1.12
import QQuickMaterialHelper.Components 1.12

Pane
{
    id: control
    padding: 0
    property bool onPrimary: false
    property bool colorReversed: onPrimary && MaterialStyle.shouldReverseForegroundOnPrimary

    property alias radius: _cardBackground.radius

    property alias backgroundColor: _cardBackground.color
    property alias outlinedColor: _cardBackground.borderColor
    property alias outlined: _cardBackground.outlined
    property alias isActive: _cardBackground.isActive

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
        isActive: (control.elevationOnHovered && control.hovered) || control.pressed || control.visualFocus
        onPrimary: control.onPrimary
        enabled: control.enabled
    } // Rectangle
}