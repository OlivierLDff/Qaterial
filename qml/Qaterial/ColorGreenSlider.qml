/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick

// Qaterial
import Qaterial as Qaterial

Qaterial.GradientSlider
{
  id: control

  property bool hsv: true

  function getNewColor()
  {
    return Qt.rgba(color.r, value, color.b, color.a)
  }

  value: color.g
  backgroundColor: "white"
  rippleColor: "transparent"
  inlineBorderWidth: 0
  handleRadius: 4

  gradient: Gradient
  {
    GradientStop
    {
      position: 0.000
      color: Qt.rgba(control.color.r, 0, control.color.b, control.color.a)
    }
    GradientStop
    {
      position: 1.000
      color: Qt.rgba(control.color.r, 1, control.color.b, control.color.a)
    }
  }
} // Slider
