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
    return hsv ? Qt.hsva(color.hsvHue, value, color.hsvValue, color.a) :
      Qt.hsla(color.hslHue, value, color.hslLightness, color.a)
  }

  value: hsv ? color.hsvSaturation : color.hslSaturation
  backgroundColor: "white"
  rippleColor: "transparent"
  inlineBorderWidth: 0
  handleRadius: 4

  gradient: Gradient
  {
    GradientStop
    {
      position: 0.000
      color: Qt.rgba(1, 1, 1, control.color.a)
    }
    GradientStop
    {
      position: 1.000
      color: control.hsv ? Qt.hsva(control.color.hsvHue, 1, control.color.hsvValue, control.color.a) : Qt.hsla(
        control.color.hslHue, 1, control.color.hslLightness, control.color.a)
    }
  }
} // Slider
