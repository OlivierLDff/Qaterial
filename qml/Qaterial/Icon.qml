/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtGraphicalEffects 1.12 as QGE

import Qaterial 1.0 as Qaterial

Item
{
  id: root

  property color color: Qaterial.Style.colorTheme.primaryText
  property alias icon: dummyImage.source
  property real size: Qaterial.Style.smallIcon
  property bool cached: true

  readonly property real _implicitSize: icon.toString() ? size : 0
  readonly property bool isImage: color.a === 0

  implicitWidth: _implicitSize
  implicitHeight: _implicitSize

  Image
  {
    id: dummyImage

    anchors.fill: parent

    fillMode: Image.PreserveAspectFit
    sourceSize: Qt.size(root.width, root.height)
    visible: root.isImage && root.enabled
  } // Image

  QGE.ColorOverlay
  {
    anchors.fill: parent

    source: dummyImage
    readonly property color implicitColor: enabled ? root.color : Qaterial.Style.colorTheme.disabledText
    color: Qt.rgba(implicitColor.r, implicitColor.g, implicitColor.b, implicitColor.a)

    cached: root.cached
    visible: !root.isImage
  } // ColorOverlay

  QGE.Colorize
  {
    anchors.fill: parent

    source: dummyImage
    hue: 0
    saturation: 0
    lightness: -0.2

    cached: root.cached
    visible: root.isImage && !root.enabled
  } // Colorize
} // Item
