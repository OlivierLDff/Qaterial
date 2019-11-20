/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

import QtQuick 2.12

import Qaterial 1.0

ColorIcon
{
	id: control
    property TextField textField
    property TextArea textArea
    property ComboBox comboBox
    iconSize: Style.textField.iconSize
    width: visible ? Style.textField.iconWidth : 0//width: Style.textField.iconWidth
    height: Style.textField.iconWidth

    property bool drawline: Style.debug.drawDebugButton
    DebugRectangle
    {
        anchors.fill: parent
        border.color: "pink"
        visible: control.drawline
    }
}
