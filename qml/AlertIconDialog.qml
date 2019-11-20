/** Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com */

// Qt
import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12

// Qaterial
import Qaterial 1.0

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

        implicitWidth: Style.dialog.implicitWidth - 2*Style.card.horizontalPadding

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
            textType: Style.TextType.ListText
            color: Style.secondaryTextColor()
            wrapMode: Text.Wrap
            elide: Text.ElideRight
            maximumLineCount: 8
        } // Label
    } //Item
} // ModalDialog
