/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick

// Qaterial
import Qaterial as Qaterial

Qaterial.TextFieldIconButton
{
  icon.source: Qaterial.Icons.closeCircle
  onClicked: function()
  {
    if(textField) textField.clear()
    if(textArea) textArea.clear()
  }
} // TextFieldIconButton
