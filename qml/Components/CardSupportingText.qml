/** 
 * Copyright (C) Olivier Le Doeuff 2019 
 * Contact: olivier.ldff@gmail.com 
 */

import QtQuick 2.12
import QtQuick.Controls 2.12

import QQuickMaterialHelper.Style 1.12
import QQuickMaterialHelper.Components 1.12

Item
{
    implicitHeight: _label.font.pixelSize*3
    implicitWidth: 200
    property alias supportingText: _label.text
    Label
    {
        id: _label
        wrapMode: Text.WordWrap
        elide: Text.ElideRight
        maximumLineCount: 2
        verticalAlignment: Text.AlignVCenter
        textType: MaterialStyle.TextType.ListSecText
        anchors.fill: parent
    }
}
