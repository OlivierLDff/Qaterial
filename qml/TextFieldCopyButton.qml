/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

import QtQuick 2.12

import Qaterial 1.0

TextFieldIconButton
{
    icon.source: "qrc:/Qaterial/Images/content-copy.svg"
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
