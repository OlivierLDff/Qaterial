/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

Qaterial.GradientSlider
{
  id: control

  property bool hsv: true

  function getNewColor()
  {
    return Qt.rgba(color.r, color.g, color.b, value)
  }

  value: color.a
  backgroundColor: "white"
  rippleColor: "transparent"
  inlineBorderWidth: 0
  handleRadius: 4

  gradient: Gradient
  {
    GradientStop
    {
      position: 0.000
      color: Qt.rgba(control.color.r, control.color.g, control.color.b, 0)
    }
    GradientStop
    {
      position: 1.000
      color: Qt.rgba(control.color.r, control.color.g, control.color.b, 1)
    }
  }
} // Slider
