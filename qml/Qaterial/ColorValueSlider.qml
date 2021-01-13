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
    return hsv ? Qt.hsva(color.hsvHue, color.hsvSaturation, value, color.a) :
      Qt.hsla(color.hslHue, color.hslSaturation, value, color.a)
  }

  value: hsv ? color.hsvValue : color.hslLightness
  backgroundColor: "white"
  rippleColor: "transparent"
  inlineBorderWidth: 0
  handleRadius: 4

  gradient: Gradient
  {
    GradientStop
    {
      position: 0.000
      color: Qt.rgba(0, 0, 0, control.color.a)
    }
    GradientStop
    {
      position: 1.000
      color: control.hsv ? Qt.hsva(control.color.hsvHue, control.color.hsvSaturation, 1, control.color.a) : Qt.hsla(
        control.color.hslHue, control.color.hslSaturation, 1, control.color.a)
    }
  }
} // Slider
