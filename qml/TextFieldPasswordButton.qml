/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

import QtQuick 2.12

import Qaterial 1.0

TextFieldIconButton
{
    icon.source: "qrc:/Qaterial/Images/eye" + (textField && (textField.echoMode !== TextInput.Password) ? "-off" : "") + ".svg"
    onClicked: if(textField) textField.echoMode = (textField.echoMode !== TextInput.Password) ? TextInput.Password : TextInput.Normal
}
