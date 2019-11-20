/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

import Qaterial 1.0

RawMaterialButton
{
    flat: true
    highlighted: checked

    icon.width: Style.toolButton.iconWidth
    icon.height: Style.toolButton.iconWidth

    topInset: Style.toolButton.topInset
    bottomInset: Style.toolButton.bottomInset
    leftInset: Style.toolButton.leftInset
    rightInset: Style.toolButton.rightInset

    leftPadding: 0
    rightPadding: 0

    backgroundImplicitWidth: Style.toolButton.minWidth
    backgroundImplicitHeight: Style.toolButton.minHeight

    property bool onPrimary: false
    property bool colorReversed: onPrimary && Style.shouldReverseForegroundOnPrimary
    property bool useSecondaryColor: false

    readonly property bool accentColorAuthorized: (onPrimary && Style.preferAccentOnPrimary || !onPrimary)

    foregroundColor: !enabled ? (colorReversed ? Style.disabledTextColorReversed() : Style.disabledTextColor()) :
                    highlighted && accentColorAuthorized ? Style.accentColor :
                    !highlighted && !accentColorAuthorized || useSecondaryColor ? (colorReversed ? Style.secondaryTextColorReversed() : Style.secondaryTextColor()) :
                    colorReversed ? Style.primaryTextColorReversed() : Style.primaryTextColor()
} // RawMaterialButton
