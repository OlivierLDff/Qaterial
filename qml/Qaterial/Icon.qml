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
  property alias icon: dummyImage.source
  property real size: 24
  property alias cached: iconOverlay.cached

  readonly property real _implicitSize: icon.toString() ? size : 0

  implicitWidth: _implicitSize
  implicitHeight: _implicitSize

  Image
  {
    id: dummyImage

    anchors.fill: parent

    fillMode: Image.PreserveAspectFit
    sourceSize: Qt.size(root.width, root.height)
    visible: false
  } // Image

  ColorOverlay
  {
    id: iconOverlay

    anchors.fill: dummyImage

    source: dummyImage
    color: Qt.rgba(root.color.r, root.color.g, root.color.b, 1)
    cached: true
  } // ColorOverlay

  opacity: color.a
} // Item
