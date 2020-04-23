/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

T.Slider
{
  id: _control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                          implicitHandleWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                           implicitHandleHeight + topPadding + bottomPadding)

  padding: 6

  handle: Qaterial.SliderHandle
  {
    x: _control.leftPadding + (_control.horizontal ? _control.visualPosition * (_control.availableWidth - width) : (_control.availableWidth - width) / 2)
    y: _control.topPadding + (_control.horizontal ? (_control.availableHeight - height) / 2 : _control.visualPosition * (_control.availableHeight - height))
    value: _control.value
    handleHasFocus: _control.visualFocus
    handlePressed: _control.pressed
    handleHovered: _control.hovered
  } // SliderHandle

  background: Rectangle
  {
    x: _control.leftPadding + (_control.horizontal ? 0 : (_control.availableWidth - width) / 2)
    y: _control.topPadding + (_control.horizontal ? (_control.availableHeight - height) / 2 : 0)
    implicitWidth: _control.horizontal ? 200 : 48
    implicitHeight: _control.horizontal ? 48 : 200
    width: _control.horizontal ? _control.availableWidth : 1
    height: _control.horizontal ? 1 : _control.availableHeight
    color: _control.Material.foreground
    scale: _control.horizontal && _control.mirrored ? -1 : 1

    Rectangle
    {
      x: _control.horizontal ? 0 : (parent.width - width) / 2
      y: _control.horizontal ? (parent.height - height) / 2 : _control.visualPosition * parent.height
      width: _control.horizontal ? _control.position * parent.width : 3
      height: _control.horizontal ? 3 : _control.position * parent.height

      color: _control.Material.accentColor
    } // Rectangle
  } // Rectangle
} // Slider
