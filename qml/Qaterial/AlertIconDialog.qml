/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

Qaterial.ModalDialog
{
  id: _control

  property alias text: _text.text

  property alias iconSource: _icon.source

  property alias iconColor: _icon.color
  property alias iconRoundColor: _icon.roundColor
  property alias iconRoundBorderColor: _icon.roundBorderColor

  property alias iconFill: _icon.fill
  property alias iconOutlined: _icon.outlined
  property alias iconhighlighted: _icon.highlighted
  property alias iconReverseHighlight: _icon.reverseHighlight

  contentItem: Item
  {
    Binding on implicitHeight
    {
      value: Math.floor(Math.max(_icon.implicitHeight, _text.implicitHeight))
      delayed: true // Prevent intermediary values from being assigned
    }

    Qaterial.RoundColorIcon
    {
      id: _icon

      anchors.verticalCenter: parent.verticalCenter
      highlighted: true
      fill: true
      visible: source != ""
    } // RoundColorIcon

    Qaterial.Label
    {
      id: _text

      text: _control.text
      x: _icon.visible ? (_icon.width + _control.horizontalPadding) : 0
      width: parent.width - x
      textType: Qaterial.Style.TextType.ListText
      color: Qaterial.Style.secondaryTextColor()
      wrapMode: Text.Wrap
      elide: Text.ElideRight
      maximumLineCount: 8
    } // Label
  } //Item
} // ModalDialog
