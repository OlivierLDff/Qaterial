/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

import QtQuick 2.12

import Qaterial 1.0

TextFieldIconButton
{
    icon.source: "qrc:/Qaterial/Images/close-circle.svg"
    onClicked:
    {
    	if(textField) textField.clear()
    	if(textArea) textArea.clear()
    }
}
