/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtGraphicalEffects 1.12

// Qaterial
import Qaterial 1.0 as Qaterial

Item
{
  id: root

  implicitWidth: size
  implicitHeight: size

  property bool enabled

  // Ripple render a focus state (same as focue)
  property bool hasFocus: false
  // Ripple render a hovered state (same as focue)
  property bool hovered: false
  // scale of handle increase when pressed, and ripple play animation
  property bool pressed: false

  // Default size of the handle
  property int size: 13
  // Radius of the handle. By default a circle.
  // Only make sense to overwrite if you control the ripple with width/height
  property alias radius: _handleRect.radius
  // Add a border to the ripple. By default no border
  property int borderWidth
  //  When the handle is pressed, this is the scale applied to the handle
  property real pressedScaleFactor: 1.5

  // When pressed, scale applied to the ripple
  property real rippleScaleFactor: 1.7

  // Ripple should clip to handle
  property bool clipRipple

  property color rippleColor: Qaterial.Style.rippleColorTheme
  property color color: Qaterial.Style.accentColor
  property color disabledColor: Qaterial.Style.disabledTextColor()
  property color borderColor: Qaterial.Style.primaryTextColor()

  Rectangle
  {
    id: _handleRect
    width: root.width
    height: root.height
    radius: width / 2
    color: root.enabled ? root.color : root.disabledColor

    border.color: root.borderColor
    border.width: root.enabled ? root.borderWidth : 0

    NumberAnimation on scale
    {
      running: root.pressed && root.enabled
      to: root.pressedScaleFactor
      duration: 100
    }

    NumberAnimation on scale
    {
      running: !root.pressed || !root.enabled
      to: 1
      duration: 250
    }
  } // Rectangle

  Qaterial.Ripple
  {
    visible: root.enabled
    x: (root.width - width) / 2
    y: (root.height - height) / 2
    width: root.clipRipple ? _handleRect.width : root.width * root.rippleScaleFactor
    height: root.clipRipple ? _handleRect.height : root.height * root.rippleScaleFactor
    scale: root.clipRipple ? _handleRect.scale : 1
    pressed: root.pressed
    active: root.pressed || root.hasFocus || root.hovered
    color: root.rippleColor
    clipRadius: root.clipRipple ? _handleRect.radius : 0

    layer.enabled: root.clipRipple
    layer.effect: OpacityMask
    {
      maskSource: Rectangle
      {
        width: _handleRect.width
        height: _handleRect.height
        radius: _handleRect.radius
        scale: _handleRect.scale
      } // Rectangle
    } // OpacityMask
  } // Ripple
} // Item
