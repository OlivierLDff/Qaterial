/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Column
{
  id: root

  property real cellWidth: 24
  property real cellHeight: 24

  property bool showName: true
  property bool showShade: true

  signal accepted(color color, string name, string shade)

  Qaterial.BaseMaterialColorPaletteGrid
  {
    cellWidth: root.cellWidth
    cellHeight: root.cellHeight

    showName: root.showName
    showShade: root.showShade

    onAccepted: (color, name, shade) => root.accepted(color, name, shade)
  }

  Row
  {
    Qaterial.AMaterialColorPaletteGrid
    {
      cellWidth: root.cellWidth
      cellHeight: root.cellHeight

      showName: root.showName
      showShade: root.showShade

      onAccepted: (color, name, shade) => root.accepted(color, name, shade)
    }

    Column
    {
      Qaterial.ColorPaletteButton
      {
        width: root.cellWidth*3
        height: root.cellHeight*2

        showName: root.showName
        showShade: root.showShade
        color: Qaterial.Colors.white
        name: "White"
        shade: ""

        onClicked: () => root.accepted(color, name, shade)
      }
      Qaterial.ColorPaletteButton
      {
        width: root.cellWidth*3
        height: root.cellHeight*2

        showName: root.showName
        showShade: root.showShade
        color: Qaterial.Colors.black
        name: "Black"
        shade: ""

        onClicked: () => root.accepted(color, name, shade)
      }
    }
  }
}
