/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

Qaterial.TextFieldIconButton
{
  icon.source: Qaterial.Icons.contentCopy
  onClicked:
  {
    if(textField)
    {
      if(textField.length > 0)
        textField.select(0, textField.length)
      textField.copy()
      textField.deselect()
    } // if
  } // onClicked
} // TextFieldIconButton
