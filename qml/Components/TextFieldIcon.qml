/** 
 * Copyright (C) Olivier Le Doeuff 2019 
 * Contact: olivier.ldff@gmail.com 
 */

import QtQuick 2.12

import QQuickMaterialHelper.Style 1.12
import QQuickMaterialHelper.Core 1.12
import QQuickMaterialHelper.Components 1.12

ColorIcon
{
	id: control
    property TextField textField
    property TextArea textArea
    property ComboBox comboBox
    iconSize: MaterialStyle.textField.iconSize
    width: visible ? MaterialStyle.textField.iconWidth : 0//width: MaterialStyle.textField.iconWidth
    height: MaterialStyle.textField.iconWidth

    property bool drawline: MaterialStyle.debug.drawDebugButton
    DebugRectangle
    {
        anchors.fill: parent
        border.color: "pink"
        visible: control.drawline
    }
}