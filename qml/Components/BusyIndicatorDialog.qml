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
    width: undefined
    closePolicy: Popup.NoAutoClose

    contentItem: Item
    {
        implicitHeight: Math.floor(_icon.implicitHeight + _text.implicitHeight + MaterialStyle.card.verticalPadding)

        implicitWidth: MaterialStyle.dialog.implicitWidth - 2*MaterialStyle.card.horizontalPadding

        BusyIndicator
        {
            id: _icon
            anchors.horizontalCenter: parent.horizontalCenter
        } // RoundColorIcon
        Label
        {
            id: _text

            text: control.text
            anchors.horizontalCenter: parent.horizontalCenter
            y: _icon.height + MaterialStyle.card.verticalPadding
            width: parent.width
            textType: MaterialStyle.TextType.ListText
            color: MaterialStyle.secondaryTextColor()
            elide: Text.ElideRight
            horizontalAlignment: Text.AlignHCenter
        } // Label
    } //Item
} // ModalDialog
