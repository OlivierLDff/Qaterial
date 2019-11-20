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

    property string text

    contentItem: Label
    {
        text: control.text
        textType: Style.TextType.ListText
        color: Style.secondaryTextColor()
        //width: control.width - control.leftPadding - control.rightPadding
        wrapMode: Text.Wrap
    }
} // Dialog
