/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

Qaterial.ColorIcon
{
  id: _control
  property Qaterial.TextField textField
  property Qaterial.TextArea textArea
  property Qaterial.ComboBox comboBox
  iconSize: Qaterial.Style.textField.iconSize
  width: visible ? Qaterial.Style.textField.iconWidth : 0 //width: Qaterial.Style.textField.iconWidth
  height: Qaterial.Style.textField.iconWidth

  property bool drawline: Qaterial.Style.debug.drawDebugButton

  Qaterial.DebugRectangle
  {
    anchors.fill: parent
    border.color: "pink"
    visible: _control.drawline
  } // DebugRectangle
} // ColorIcon
