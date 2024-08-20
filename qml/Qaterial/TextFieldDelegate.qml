/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick
import QtQuick.Controls

// Qaterial
import Qaterial as Qaterial

// TO DO : improve that to use Qaterial.DialogManager
Qaterial.ItemDelegate
{
  id: _control

  signal accepted(string value)
  signal rejected()

  property alias value: _textFieldDialog.text
  property alias textTitle: _textFieldDialog.textTitle
  property alias prefixText: _textFieldDialog.prefixText
  property alias suffixText: _textFieldDialog.suffixText
  property alias errorText: _textFieldDialog.errorText
  property alias errorState: _textFieldDialog.errorState
  property alias error: _textFieldDialog.error

  property alias placeholderText: _textFieldDialog.placeholderText
  property alias helperText: _textFieldDialog.helperText
  property alias validator: _textFieldDialog.validator
  property alias acceptableInput: _textFieldDialog.acceptableInput
  property alias echoMode: _textFieldDialog.echoMode
  property alias inputMethodHints: _textFieldDialog.inputMethodHints
  property alias maximumLength: _textFieldDialog.maximumLength
  property alias maximumLengthCount: _textFieldDialog.maximumLengthCount
  property alias length: _textFieldDialog.length
  property alias leadingIconSource: _textFieldDialog.leadingIconSource
  property alias trailingContent: _textFieldDialog.trailingContent
  property alias leadingIconInline: _textFieldDialog.leadingIconInline
  property alias leadingIconVisible: _textFieldDialog.leadingIconVisible
  property alias leadingIconErrorAnimation: _textFieldDialog.leadingIconErrorAnimation
  property alias trailingInline: _textFieldDialog.trailingInline
  property alias selectAllText: _textFieldDialog.selectAllText

  property alias title: _textFieldDialog.title

  Qaterial.TextFieldDialog
  {
    id: _textFieldDialog
    onAccepted: _control.accepted(text)
    onRejected: _control.rejected()
  } // TextFieldDialog

  onClicked: _textFieldDialog.open()
} // ItemDelegate
