/** Copyright (C) Olivier Le Doeuff 2019 
 * Contact: olivier.ldff@gmail.com */

import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12

import QQuickMaterialHelper.Style 1.12
import QQuickMaterialHelper.Core 1.12
import QQuickMaterialHelper.Components 1.12

ModalDialog
{
    id: control

    property alias text: _text.text

    property alias iconSource: _icon.source

    property alias iconColor: _icon.color
    property alias iconRoundColor: _icon.roundColor
    property alias iconRoundBorderColor: _icon.roundBorderColor
    
    property alias iconFill: _icon.fill
    property alias iconOutlined: _icon.outlined
    property alias iconhighlighted: _icon.highlighted
    property alias iconReverseHighlight: _icon.reverseHighlight

    width: undefined

    contentItem: Item
    {
        implicitHeight: Math.floor(Math.max(_icon.implicitHeight, _text.implicitHeight))

        implicitWidth: MaterialStyle.dialog.implicitWidth - 2*MaterialStyle.card.horizontalPadding

        RoundColorIcon
        {
            id: _icon

            anchors.verticalCenter: parent.verticalCenter
            highlighted: true
            fill: true
            visible: source != ""
        } // RoundColorIcon
        Label
        {
            id: _text

            text: control.text
            x: _icon.visible ? (_icon.width + control.horizontalPadding) : 0
            width: parent.width - x
            textType: MaterialStyle.TextType.ListText
            color: MaterialStyle.secondaryTextColor()
            wrapMode: Text.Wrap
            elide: Text.ElideRight
            maximumLineCount: 8
        } // Label
    } //Item
} // ModalDialog
