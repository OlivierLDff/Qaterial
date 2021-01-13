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
    return hsv ? Qt.hsva(value, color.hsvSaturation, color.hsvValue, color.a) :
      Qt.hsla(value, color.hslSaturation, color.hslLightness, color.a)
  }

  value: hsv ? color.hsvHue : color.hslHue
  backgroundColor: "white"
  rippleColor: "transparent"
  inlineBorderWidth: 0
  handleRadius: 4

  gradient: Gradient
  {
    GradientStop { position: 0.000;color: Qt.rgba(1, 0, 0, 1) }
    GradientStop { position: 0.167;color: Qt.rgba(1, 1, 0, 1) }
    GradientStop { position: 0.333;color: Qt.rgba(0, 1, 0, 1) }
    GradientStop { position: 0.500;color: Qt.rgba(0, 1, 1, 1) }
    GradientStop { position: 0.667;color: Qt.rgba(0, 0, 1, 1) }
    GradientStop { position: 0.833;color: Qt.rgba(1, 0, 1, 1) }
    GradientStop { position: 1.000;color: Qt.rgba(1, 0, 0, 1) }
  }
} // Slider
