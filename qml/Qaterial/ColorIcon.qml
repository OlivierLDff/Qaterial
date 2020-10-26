/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtGraphicalEffects 1.12

import Qaterial 1.0 as Qaterial

Item
{
  id: root

  // ICON CONTROL
  property alias source: _image.source
  property bool fill: false
  property bool outlined: false
  property bool roundIcon: fill || outlined
  property alias mirror: _image.mirror
  property bool roundOpacity: true

  // COLORS
  property color color: Qaterial.Style.primaryTextColor()
  property color roundColor
  property color roundBorderColor: roundColor

  // SIZE
  width: roundIcon ? roundSize : iconSize
  height: roundIcon ? roundSize : iconSize

  property double iconSize: 24
  property double roundSize: 40

  Rectangle
  {
    id: _round
    width: root.roundSize
    height: root.roundSize
    color: root.fill ? root.roundColor : "transparent"
    radius: root.roundSize / 2
    visible: root.roundIcon
    border.width: root.outlined ? 1 : 0
    border.color: root.outlined ? root.roundBorderColor : "transparent"
    opacity: roundOpacity ? 0.5 : 1.0
  } // Rectangle

  Image
  {
    id: _image
    width: root.iconSize
    height: root.iconSize
    visible: false
    fillMode: Image.PreserveAspectFit
    sourceSize.height: root.iconSize
    sourceSize.width: root.iconSize
    anchors.centerIn: parent
  } // Image

  ColorOverlay
  {
    source: _image
    anchors.fill: _image
    color.r: root.color.r
    color.g: root.color.g
    color.b: root.color.b
    color.a: 1
    cached: true
  } // ColorOverlay

  opacity: color.a
} // Item
