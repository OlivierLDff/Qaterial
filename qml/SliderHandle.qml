/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

Item
{
  id: _root
  implicitWidth: initialSize
  implicitHeight: initialSize

  property bool enabled

  property real value: 0
  property bool handleHasFocus: false
  property bool handlePressed: false
  property bool handleHovered: false
  readonly property int initialSize: 13

  property color rippleColor: Qaterial.Style.rippleColorTheme
  property color accentColor: Qaterial.Style.accentColor
  property color disabledColor: Qaterial.Style.disabledTextColor()

  Rectangle
  {
    id: _handleRect
    width: parent.width
    height: parent.height
    radius: width / 2
    color: _root.enabled ? _root.accentColor : _root.disabledColor
    scale: _root.handlePressed ? 1.5 : 1

    Behavior on scale
    {
      NumberAnimation
      {
        duration: 250
      } // NumberAnimation
    } // Behavior
  } // Rectangle

  Qaterial.Ripple
  {
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    width: 22; height: 22
    pressed: _root.handlePressed
    active: _root.handlePressed || _root.handleHasFocus || _root.handleHovered
    color: _root.rippleColor
  } // Ripple
} // Item
