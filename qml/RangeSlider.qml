/**
 * Copyright (C) Paul Cales 2020
 * Contact: cales.paul@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Templates 2.12 as T

// Qaterial
import Qaterial 1.0 as Qaterial

T.RangeSlider
{
  id: _control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                          first.implicitHandleWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                           first.implicitHandleHeight + topPadding + bottomPadding)

  padding: 6

  property color rippleColor: Qaterial.Style.rippleColorTheme
  property color accentColor: Qaterial.Style.accentColor
  property color foregroundColor: Qaterial.Style.hintTextColor()
  property color disabledColor: Qaterial.Style.disabledTextColor()
  property color backgroundDisabledColor: Qaterial.Style.disabledDividersColor()

  first.handle: Qaterial.SliderHandle
  {
    x: _control.leftPadding + (_control.horizontal ? _control.first.visualPosition * (_control.availableWidth - width) : (_control.availableWidth - width) / 2)
    y: _control.topPadding + (_control.horizontal ? (_control.availableHeight - height) / 2 : _control.first.visualPosition * (_control.availableHeight - height))
    value: _control.first.value
    handleHasFocus: _control.visualFocus
    handlePressed: _control.first.pressed
    handleHovered: _control.first.hovered
    rippleColor: _control.rippleColor
    accentColor: _control.accentColor
    disabledColor: _control.disabledColor
    enabled: _control.enabled
  } // SliderHandle

  second.handle: Qaterial.SliderHandle
  {
    x: _control.leftPadding + (_control.horizontal ? _control.second.visualPosition * (_control.availableWidth - width) : (_control.availableWidth - width) / 2)
    y: _control.topPadding + (_control.horizontal ? (_control.availableHeight - height) / 2 : _control.second.visualPosition * (_control.availableHeight - height))
    value: _control.second.value
    handleHasFocus: _control.visualFocus
    handlePressed: _control.second.pressed
    handleHovered: _control.second.hovered
    rippleColor: _control.rippleColor
    accentColor: _control.accentColor
    disabledColor: _control.disabledColor
    enabled: _control.enabled
  } // SliderHandle

  property int backgroundImplicitWidth: horizontal ? 200 : 34
  property int backgroundImplicitHeight: horizontal ? 34 : 200

  background: Rectangle
  {
    x: _control.leftPadding + (_control.horizontal ? 0 : (_control.availableWidth - width) / 2)
    y: _control.topPadding + (_control.horizontal ? (_control.availableHeight - height) / 2 : 0)
    implicitWidth: _control.backgroundImplicitWidth
    implicitHeight: _control.backgroundImplicitHeight
    width: _control.horizontal ? _control.availableWidth : 1
    height: _control.horizontal ? 1 : _control.availableHeight
    color: _control.enabled ? _control.foregroundColor : _control.backgroundDisabledColor
    scale: _control.horizontal && _control.mirrored ? -1 : 1

    Rectangle
    {
      x: _control.horizontal ? _control.first.position * parent.width : (parent.width - width) / 2
      y: _control.horizontal ? (parent.height - height) / 2 : _control.second.visualPosition * parent.height
      width: _control.horizontal ? _control.second.position * parent.width - _control.first.position * parent.width : 3
      height: _control.horizontal ? 3 : _control.second.position * parent.height - _control.first.position * parent.height
      color: _control.enabled ? _control.accentColor : _control.disabledColor
    } // Rectangle
  } // Rectangle
} // RangeSlider
