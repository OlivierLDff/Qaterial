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

    property string text

    contentItem: Label
    {
        text: control.text
        textType: MaterialStyle.TextType.ListText
        color: MaterialStyle.secondaryTextColor()
        //width: control.width - control.leftPadding - control.rightPadding
        wrapMode: Text.Wrap
    }
} // Dialog
