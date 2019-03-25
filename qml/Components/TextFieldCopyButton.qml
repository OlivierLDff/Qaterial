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
    icon.source: "qrc:/QQuickMaterialHelper/Components/images/content-copy.svg"
    onClicked: 
    {
        if(textField) 
        {
            if(textField.length>0)
                textField.select(1, textField.length)
            textField.copy()
            textField.deselect()
        }
    }
}