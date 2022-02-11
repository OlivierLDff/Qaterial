/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qaterial
import Qaterial as Qaterial

Qaterial.RoundButton
{
  leftPadding: 0
  rightPadding: 0

  topInset: Qaterial.Style.toolButton.padding
  bottomInset: Qaterial.Style.toolButton.padding
  leftInset: Qaterial.Style.toolButton.padding
  rightInset: Qaterial.Style.toolButton.padding

  backgroundImplicitWidth: Qaterial.Style.toolButton.appBarButtonWidth
  backgroundImplicitHeight: Qaterial.Style.toolButton.appBarButtonHeight

  foregroundColor:
  {
    if(!enabled)
      return colorReversed ? Qaterial.Style.disabledTextColorReversed() : Qaterial.Style.disabledTextColor()
    if(highlighted)
      return Qaterial.Style.accentColor
    return colorReversed ? Qaterial.Style.primaryTextColorReversed() : Qaterial.Style.primaryTextColor()
  }
} // RoundButton
