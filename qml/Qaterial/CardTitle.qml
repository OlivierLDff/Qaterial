/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

Item
{
  id: _control
  implicitHeight: _column.implicitHeight
  implicitWidth: 200 //_column.implicitWidth

  property alias headerText: _title.text
  property alias subHeaderText: _text.text
  property alias spacing: _column.spacing

  property bool mirrored: false

  property bool onPrimary: false
  property bool colorReversed: onPrimary && Qaterial.Style.shouldReverseForegroundOnPrimary

  property alias padding: _column.padding
  property alias leftPadding: _column.leftPadding
  property alias rightPadding: _column.rightPadding
  property alias topPadding: _column.topPadding
  property alias bottomPadding: _column.bottomPadding

  property bool drawline: Qaterial.Style.debug.drawDebugIconLabel

  Qaterial.DebugRectangle
  {
    anchors.fill: parent
    border.color: "green"
    visible: _control.drawline
  } // DebugRectangle

  Column
  {
    id: _column
    anchors.right: parent.right
    anchors.left: parent.left

    Qaterial.Label
    {
      id: _title
      textType: Qaterial.Style.TextType.Title
      elide: Text.ElideRight
      horizontalAlignment: _control.mirrored ? Text.AlignRight : Text.AlignLeft
      width: parent.width - _control.rightPadding - _control.leftPadding

      Qaterial.DebugRectangle
      {
        anchors.fill: parent
        border.color: "pink"
        visible: _control.drawline
      } // DebugRectangle
    } // Label

    Qaterial.Label
    {
      id: _text
      textType: Qaterial.Style.TextType.ListSecText
      elide: Text.ElideRight
      horizontalAlignment: _control.mirrored ? Text.AlignRight : Text.AlignLeft
      width: parent.width - _control.rightPadding - _control.leftPadding

      Qaterial.DebugRectangle
      {
        anchors.fill: parent
        border.color: "pink"
        visible: _control.drawline
      } // DebugRectangle
    } // Label
  } // Column
} // Item
