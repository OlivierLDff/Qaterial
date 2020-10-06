/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

import QtQuick 2.12

import Qaterial 1.0 as Qaterial

GridView
{
  id: root

  property int columns: 1
  property int rows: 1

  property bool showName: true
  property bool showShade: true

  signal accepted(color color, string name, string shade)

  implicitWidth: columns*cellWidth
  implicitHeight: rows*cellHeight

  interactive: false

  cellWidth: 24
  cellHeight: 24

  flow: GridView.FlowTopToBottom

  delegate: Qaterial.ColorPaletteButton
  {
    showName: root.showName
    showShade: root.showShade

    light: model.light
    name: model.name
    shade: model.shade
    color: model.color

    width: root.cellWidth
    height: root.cellHeight

    onClicked: () => root.accepted(color, name, shade)
  }
}
