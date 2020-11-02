/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12

// Qaterial
import Qaterial 1.0 as Qaterial

Item
{
  id: _indicator
  implicitWidth: Qaterial.Style.switchIndicator.implicitWidth
  implicitHeight: Qaterial.Style.switchIndicator.implicitHeight

  property Item control
  property alias handle: _handle

  property int elevation: control.enabled ? 1 : 0

  Rectangle
  {
    width: parent.width
    height: Qaterial.Style.switchIndicator.trackHeight
    radius: height / 2
    y: parent.height / 2 - height / 2
    color: control.enabled ? (control.checked ? Qaterial.Style.switchIndicator.switchCheckedTrackColor : Qaterial.Style
      .switchIndicator.switchUncheckedTrackColor) : Qaterial.Style.switchIndicator.switchDisabledTrackColor
  } // Rectangle

  Rectangle
  {
    id: _handle
    x: Math.max(0, Math.min(parent.width - width, control.visualPosition * parent.width - (width / 2)))
    y: (parent.height - height) / 2
    width: Qaterial.Style.switchIndicator.handleRadius
    height: Qaterial.Style.switchIndicator.handleRadius
    radius: width / 2
    color: control.enabled ? (control.checked ? Qaterial.Style.switchIndicator.switchCheckedHandleColor : Qaterial.Style
      .switchIndicator.switchUncheckedHandleColor) : Qaterial.Style.switchIndicator.switchDisabledHandleColor

    Behavior on x
    {
      enabled: !control.pressed
      SmoothedAnimation { duration: 300 }
    } // Behavior

    layer.enabled: _indicator.elevation > 0
    layer.effect: Qaterial.ElevationEffect
    {
      elevation: _indicator.elevation
    } // ElevationEffect
  } // Rectangle
} // Item
