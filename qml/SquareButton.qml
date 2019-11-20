/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

import Qaterial 1.0

RawMaterialButton
{
    flat: true
    highlighted: checked

    icon.width: MaterialStyle.toolButton.iconWidth
    icon.height: MaterialStyle.toolButton.iconWidth

    topInset: MaterialStyle.toolButton.topInset
    bottomInset: MaterialStyle.toolButton.bottomInset
    leftInset: MaterialStyle.toolButton.leftInset
    rightInset: MaterialStyle.toolButton.rightInset

    leftPadding: 0
    rightPadding: 0

    backgroundImplicitWidth: MaterialStyle.toolButton.minWidth
    backgroundImplicitHeight: MaterialStyle.toolButton.minHeight

    property bool onPrimary: false
    property bool colorReversed: onPrimary && MaterialStyle.shouldReverseForegroundOnPrimary
    property bool useSecondaryColor: false

    readonly property bool accentColorAuthorized: (onPrimary && MaterialStyle.preferAccentOnPrimary || !onPrimary)

    foregroundColor: !enabled ? (colorReversed ? MaterialStyle.disabledTextColorReversed() : MaterialStyle.disabledTextColor()) :
                    highlighted && accentColorAuthorized ? MaterialStyle.accentColor :
                    !highlighted && !accentColorAuthorized || useSecondaryColor ? (colorReversed ? MaterialStyle.secondaryTextColorReversed() : MaterialStyle.secondaryTextColor()) :
                    colorReversed ? MaterialStyle.primaryTextColorReversed() : MaterialStyle.primaryTextColor()
} // RawMaterialButton
