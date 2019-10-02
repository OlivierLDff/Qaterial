/** Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com */

import QtQuick 2.12
import QtQuick.Controls 2.12

import QQuickMaterialHelper.Components 1.12

ModalDialog
{
    id: root

    property bool selectAllText: false

    property alias textTitle: _textField.title
    property alias prefixText: _textField.prefixText
    property alias suffixText: _textField.suffixText
    property alias errorText: _textField.errorText
    property alias errorState: _textField.errorState
    property alias error: _textField.error
    property alias text: _textField.text
    property alias placeholderText: _textField.placeholderText
    property alias helperText: _textField.helperText
    property alias validator: _textField.validator
    property alias acceptableInput: _textField.acceptableInput
    property alias echoMode: _textField.echoMode
    property alias inputMethodHints: _textField.inputMethodHints
    property alias maximumLength: _textField.maximumLength
    property alias maximumLengthCount: _textField.maximumLengthCount
    property alias length: _textField.length
    property alias leadingIconSource: _textField.leadingIconSource
    property alias trailingContent: _textField.trailingContent
    property alias leadingIconInline: _textField.leadingIconInline
    property alias leadingIconVisible: _textField.leadingIconVisible
    property alias leadingIconErrorAnimation: _textField.leadingIconErrorAnimation
    property alias trailingInline: _textField.trailingInline

    standardButtons: Dialog.Ok | Dialog.Cancel
    contentItem: TextField
    {
        id: _textField
        focus: true
        onAccepted: root.accept()
    }

    onOpened : if(root.selectAllText) _textField.selectAll()
}
