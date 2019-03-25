/** 
 * Copyright (C) Olivier Le Doeuff 2019 
 * Contact: olivier.ldff@gmail.com 
 */
 
import QQuickMaterialHelper.Style 1.12
import QQuickMaterialHelper.Core 1.12

SquareButton
{
    highlighted: checked || pressed
    forceRipple: checked
    accentRipple: highlighted
    checkable: true
    useSecondaryColor: true
} // SquareButton
