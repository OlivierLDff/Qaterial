/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Controls 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

Qaterial.Pane
{
  id: _control

  // TEXT
  property string text

  // ACTION
  property alias action: _action.text
  signal actionPressed()

  padding: 0

  elevation: Qaterial.Style.snackbar.elevation
  radius: Qaterial.Style.snackbar.radius

  property bool drawline: Qaterial.Style.debug.drawDebugDelegate
  color: Qaterial.Style.snackbarColor()

  property bool expandable: false

  contentItem: Item
  {
    id: _content
    implicitWidth: _control.expandable ? (Math.max(Qaterial.Style.snackbar.implicitWidth, _label.implicitWidth +
        _action.implicitWidth) + Qaterial.Style.card.horizontalPadding * (_control.action != "" ? 3 : 2)) : Qaterial
      .Style.snackbar.implicitWidth
    implicitHeight: (_label.lineCount > 1) ? Qaterial.Style.snackbar.implicitHeight2 : Qaterial.Style.snackbar
      .implicitHeight

    Qaterial.DebugRectangle
    {
      anchors.fill: parent
      border.color: "pink"
      visible: _control.drawline
    } // DebugRectangle

    Qaterial.Label // Label when there is only one action or in desktop mode
    {
      id: _label
      text: _control.text
      anchors.verticalCenter: _content.verticalCenter
      anchors.left: parent.left
      anchors.leftMargin: Qaterial.Style.card.horizontalPadding
      anchors.right: (_control.action != "") ? _action.left : parent.right
      anchors.rightMargin: (_control.action != "") ? Qaterial.Style.card.horizontalPadding : Qaterial.Style.card
        .verticalPadding
      maximumLineCount: _control.expandable ? 1 : 2
      wrapMode: _control.expandable ? Text.NoWrap : Text.WordWrap
      elide: (_control.mirrored ? Text.ElideLeft : Text.ElideRight)

      color: Qaterial.Style.snackbarTextColor()

      Qaterial.DebugRectangle
      {
        anchors.fill: parent
        border.color: "red"
        visible: _control.drawline
      } // DebugRectangle
    } // Label

    Qaterial.FlatButton
    {
      id: _action
      visible: text
      onPressed: _control.actionPressed()
      anchors.right: parent.right
      anchors.rightMargin: 2
      anchors.verticalCenter: _content.verticalCenter
      anchors.verticalCenterOffset: _label.lineCount > 1 ? implicitHeight / 6 : 0
      onPrimary: true
      rippleColor: Qaterial.Style.snackbarRippleColor()
    } // FlatButton
  } // Item
} // Pane
