/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qaterial
import Qaterial 1.0

RoundButton
{
    leftPadding: 0
    rightPadding: 0

    topInset: Style.toolButton.padding
    bottomInset: Style.toolButton.padding
    leftInset: Style.toolButton.padding
    rightInset: Style.toolButton.padding

    backgroundImplicitWidth: Style.toolButton.appBarButtonWidth
    backgroundImplicitHeight: Style.toolButton.appBarButtonHeight

    foregroundColor: !enabled ? (colorReversed ? Style.disabledTextColorReversed() : Style.disabledTextColor()) :
                    highlighted ? Style.accentColor : (colorReversed ? Style.primaryTextColorReversed() : Style.primaryTextColor())
} // RoundButton
