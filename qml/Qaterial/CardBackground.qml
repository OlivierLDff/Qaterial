/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick
import QtQuick.Controls

// Qaterial
import Qaterial as Qaterial

Rectangle
{
  id: control
  property bool enabled: true
  property bool outlined: false
  property bool isActive: false
  property double elevation:
  {
    if(isActive)
      return Qaterial.Style.card.activeElevation
    return outlined ? 0 : Qaterial.Style.card.defaultElevation
  }

  property bool onPrimary: false
  property bool colorReversed: onPrimary && Qaterial.Style.shouldReverseForegroundOnPrimary

  color: onPrimary ? Qaterial.Style.primaryColor : Qaterial.Style.cardColor
  property color borderColor: enabled ? Qaterial.Style.dividersColor() : Qaterial.Style.disabledDividersColor()
  radius: Qaterial.Style.card.radius
  border.width: outlined ? 1 : 0
  border.color: isActive ? "transparent" : borderColor

  Behavior on border.color
  {
    ColorAnimation
    {
      duration: 250
      easing.type: Easing.OutCubic
    } // ColorAnimation
  } // Behavior

  Behavior on elevation
  {
    NumberAnimation
    {
      duration: 250
      easing.type: Easing.OutCubic
    } // NumberAnimation
  } // Behavior

  layer.enabled: control.enabled && control.elevation > 0
  layer.effect: Qaterial.ElevationEffect { elevation: control.elevation }
} // Rectangle
