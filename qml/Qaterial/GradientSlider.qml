/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtGraphicalEffects 1.12

// Qaterial
import Qaterial 1.0 as Qaterial

Qaterial.LargeSlider
{
  id: control

  backgroundColor: "white"
  property alias gradient: _gradient.gradient

  LinearGradient
  {
    id: _gradient
    visible: control.enabled

    x: background.x
    y: background.y
    width: background.width
    height: background.height

    start: Qt.point(0, control.horizontal ? 0 : height)
    end: Qt.point(control.horizontal ? width : 0, 0)

    source: background
  }
} // Slider
