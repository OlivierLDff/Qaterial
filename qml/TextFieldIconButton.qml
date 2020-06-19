/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

Qaterial.AppBarButton
{
  property Qaterial.TextField textField
  property Qaterial.TextArea textArea
  property Qaterial.ComboBox comboBox
  backgroundImplicitHeight: Qaterial.Style.textField.iconWidth
  topInset: 0
  bottomInset: 0
  foregroundColor:
  {
    if(enabled)
    {
      if(colorReversed)
        return Qaterial.Style.secondaryTextColorReversed()
      return Qaterial.Style.secondaryTextColor()
    }
    if(colorReversed)
      return Qaterial.Style.disabledTextColorReversed()
    return Qaterial.Style.disabledTextColor()
  }

  width: visible ? implicitWidth : 0
} // AppBarButton
