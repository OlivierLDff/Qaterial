/** 
 * Copyright (C) Olivier Le Doeuff 2019 
 * Contact: olivier.ldff@gmail.com 
 */

import QtQuick 2.12

import QQuickMaterialHelper.Style 1.12
import QQuickMaterialHelper.Core 1.12
import QQuickMaterialHelper.Components 1.12

TextFieldIconButton
{
    icon.source: "qrc:/QQuickMaterialHelper/Components/images/eye" + (textField && (textField.echoMode !== TextInput.Password) ? "-off" : "") + ".svg"
    onClicked: if(textField) textField.echoMode = (textField.echoMode !== TextInput.Password) ? TextInput.Password : TextInput.Normal 
}