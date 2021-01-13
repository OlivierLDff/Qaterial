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
  icon.source: textField && (textField.echoMode !== TextInput.Password) ? Qaterial.Icons.eyeOff : Qaterial.Icons.eye
  onClicked: if(textField) textField.echoMode = (textField.echoMode !== TextInput.Password) ? TextInput.Password :
    TextInput.Normal
} // TextFieldIconButton
