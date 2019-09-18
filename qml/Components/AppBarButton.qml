/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

import QQuickMaterialHelper.Style 1.12
import QQuickMaterialHelper.Components 1.12

RoundButton
{
    leftPadding: 0
    rightPadding: 0

    topInset: MaterialStyle.toolButton.padding
    bottomInset: MaterialStyle.toolButton.padding
    leftInset: MaterialStyle.toolButton.padding
    rightInset: MaterialStyle.toolButton.padding

    backgroundImplicitWidth: MaterialStyle.toolButton.appBarButtonWidth
    backgroundImplicitHeight: MaterialStyle.toolButton.appBarButtonHeight

    foregroundColor: !enabled ? (colorReversed ? MaterialStyle.disabledTextColorReversed() : MaterialStyle.disabledTextColor()) :
                    colorReversed ? MaterialStyle.primaryTextColorReversed() : MaterialStyle.primaryTextColor()
} // RoundButton