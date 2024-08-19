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
    return Qt.rgba(color.r, color.g, value, color.a)
  }

  value: color.b
  backgroundColor: "white"
  rippleColor: "transparent"
  inlineBorderWidth: 0
  handleRadius: 4

  gradient: Gradient
  {
    GradientStop
    {
      position: 0.000
      color: Qt.rgba(control.color.r, control.color.g, 0, control.color.a)
    }
    GradientStop
    {
      position: 1.000
      color: Qt.rgba(control.color.r, control.color.g, 1, control.color.a)
    }
  }
} // Slider
