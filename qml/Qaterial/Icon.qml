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

  property color color: Qaterial.Style.primaryTextColor()
  property url icon
  property real size: 24

  implicitWidth: size
  implicitHeight: size

  Image
  {
    id: dummyImage

    width: root.width
    height: root.height
    fillMode: Image.PreserveAspectFit
    source: root.icon
    sourceSize: Qt.size(parent.width, parent.height)
    visible: false
  } // Image

  ColorOverlay
  {
    anchors.fill: dummyImage
    source: dummyImage
    color: Qt.rgba(root.color.r, root.color.g, root.color.b, 1)
    cached: true
  } // ColorOverlay

  opacity: color.a
} // Item
