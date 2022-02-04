/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick

// Qaterial
import Qaterial as Qaterial
import Qaterial.Qt5Compat as Qaterial

Qaterial.GradientSlider
{
  id: control

  property bool hsv: true

  function getNewColor()
  {
    return Qt.rgba(value, color.g, color.b, color.a)
  }

  value: color.r
  backgroundColor: "white"
  rippleColor: "transparent"
  inlineBorderWidth: 0
  handleRadius: 4

  gradient: Gradient
  {
    GradientStop
    {
      position: 0.000
      color: Qt.rgba(0, control.color.g, control.color.b, control.color.a)
    }
    GradientStop
    {
      position: 1.000
      color: Qt.rgba(1, control.color.g, control.color.b, control.color.a)
    }
  }
} // Slider
