/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

Rectangle
{
  id: _root
  color: "#202020"
  border.width: 1
  border.color: "#101010"
  implicitWidth: 200
  implicitHeight: _mainColumn.height

  property string title: ""
  property alias content: _loader.sourceComponent
  property bool expanded: false

  Item
  {
    id: _mainColumn
    height: _header.height + _expandableRect.height
    width: parent.width

    Rectangle
    {
      id: _header

      width: _root.width
      height: 30
      color: "#101010"

      Qaterial.AppBarButton
      {
        id: _expandButton
        icon.source: _root.expanded ? Qaterial.Icons.menuDown : Qaterial.Icons.menuRight
        backgroundImplicitWidth: Qaterial.Style.dense ? 12 : 16
        backgroundImplicitHeight: Qaterial.Style.dense ? 12 : 16
        leftPadding: 0
        rightPadding: 0
        anchors.verticalCenter: parent.verticalCenter

        onClicked: _root.expanded = !_root.expanded
      } // AppBarButton

      Qaterial.LabelSubtitle1
      {
        text: _root.title
        anchors.verticalCenter: parent.verticalCenter
        x: 4 + _expandButton.implicitWidth
        width: parent.width - 4 - _expandButton.width
        elide: Text.ElideRight
      } // Label
    } // Rectangle

    Item
    {
      id: _expandableRect
      clip: true
      y: _header.height
      height: _root.expanded && _loader.item ? _loader.item.height : 0
      width: _root.width

      Loader
      {
        id: _loader
        x: 8
        width: _expandableRect.width - 8
        active: _root.expanded
      } // Loader
    } // Item
  } // Item
} // Rectangle
