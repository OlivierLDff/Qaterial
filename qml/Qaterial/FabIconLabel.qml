/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Controls 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

Item
{
  id: _control

  property
  var icon: QtObject
  {
    property double width: 24
    property double height: width
    property string source: ""
  } // QtObject

  property alias text: _label.text
  property color color
  property alias font: _label.font
  property bool mirrored: false
  property double spacing: 0
  property int elide: Text.ElideNone

  readonly property bool iconVisible: display != AbstractButton.TextOnly
  readonly property bool labelVisible: display != AbstractButton.IconOnly

  readonly property double iconWidth: (iconVisible ? icon.width : 0)
  readonly property double iconHeight: (iconVisible ? icon.height : 0)

  readonly property double labelWidth: (labelVisible ? _label.contentWidth : 0)
  readonly property double labelHeight: (labelVisible ? _label.contentHeight : 0)

  implicitWidth: iconWidth + labelWidth + (labelVisible ? spacing : 0)
  implicitHeight: Math.max(iconHeight, labelHeight)

  property bool drawline: Qaterial.Style.debug.drawDebugIconLabel

  // AbstractButton.IconOnly | AbstractButton.TextOnly | AbstractButton.TextBesideIcon | AbstractButton.TextUnderIcon
  property int display: AbstractButton.TextBesideIcon

  Qaterial.DebugRectangle
  {
    anchors.fill: parent
    border.color: "green"
    visible: _control.drawline
  } // DebugRectangle

  Item
  {
    id: _iconItem
    width: _control.icon.width
    height: _control.icon.height

    Qaterial.ColorIcon
    {
      id: _icon
      source: _control.icon.source
      width: _control.icon.width
      height: _control.icon.height
      color: _control.color

      anchors.centerIn: parent
    } // ColorIcon

    Qaterial.DebugRectangle
    {
      anchors.fill: parent
      border.color: "red"
      visible: _control.drawline
    } // DebugRectangle

    anchors.verticalCenter: _control.verticalCenter
    anchors.right: _control.mirrored ? _control.right : undefined
    anchors.left: !_control.mirrored ? _control.left : undefined
  } // Item

  Qaterial.Label
  {
    id: _label
    color: _control.color
    elide: _control.elide
    visible: width > 0
    clip: true

    anchors.left: !mirrored ? _iconItem.right : _control.left
    anchors.right: mirrored ? _iconItem.left : _control.right

    anchors.leftMargin: !mirrored ? _control.spacing : 0
    anchors.rightMargin: mirrored ? _control.spacing : 0
    anchors.verticalCenter: _control.verticalCenter

    Qaterial.DebugRectangle
    {
      anchors.fill: parent
      border.color: "red"
      visible: _control.drawline
    } // DebugRectangle
  } // Label
} // Item
