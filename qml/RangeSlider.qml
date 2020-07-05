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
  id: control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                          first.implicitHandleWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                           first.implicitHandleHeight + topPadding + bottomPadding)

  padding: Qaterial.Style.slider.padding

  property color rippleColor: Qaterial.Style.rippleColorTheme
  property color accentColor: Qaterial.Style.accentColor
  property color foregroundColor: Qaterial.Style.hintTextColor()
  property color disabledColor: Qaterial.Style.disabledTextColor()
  property color backgroundDisabledColor: Qaterial.Style.disabledDividersColor()

  first.handle: Qaterial.SliderHandle
  {
    x: control.leftPadding + (control.horizontal ? control.first.visualPosition * (control.availableWidth - width) : (control.availableWidth - width) / 2)
    y: control.topPadding + (control.horizontal ? (control.availableHeight - height) / 2 : control.first.visualPosition * (control.availableHeight - height))
    value: control.first.value
    hasFocus: control.visualFocus
    hovered: control.first.hovered
    pressed: control.first.pressed
    rippleColor: control.rippleColor
    accentColor: control.accentColor
    disabledColor: control.disabledColor
    enabled: control.enabled
  } // SliderHandle

  second.handle: Qaterial.SliderHandle
  {
    x: control.leftPadding + (control.horizontal ? control.second.visualPosition * (control.availableWidth - width) : (control.availableWidth - width) / 2)
    y: control.topPadding + (control.horizontal ? (control.availableHeight - height) / 2 : control.second.visualPosition * (control.availableHeight - height))
    value: control.second.value
    hasFocus: control.visualFocus
    hovered: control.second.hovered
    pressed: control.second.pressed
    rippleColor: control.rippleColor
    accentColor: control.accentColor
    disabledColor: control.disabledColor
    enabled: control.enabled

    opacity: 0.5
  } // SliderHandle

  property int backgroundImplicitWidth: horizontal ? Qaterial.Style.slider.implicitWidth : Qaterial.Style.slider.implicitHeight
  property int backgroundImplicitHeight: horizontal ? Qaterial.Style.slider.implicitHeight : Qaterial.Style.slider.implicitWidth

  background: Rectangle
  {
    x: control.leftPadding + (control.horizontal ? 0 : (control.availableWidth - width) / 2)
    y: control.topPadding + (control.horizontal ? (control.availableHeight - height) / 2 : 0)
    implicitWidth: control.backgroundImplicitWidth
    implicitHeight: control.backgroundImplicitHeight
    width: control.horizontal ? control.availableWidth : 1
    height: control.horizontal ? 1 : control.availableHeight
    color: control.enabled ? control.foregroundColor : control.backgroundDisabledColor
    scale: control.horizontal && control.mirrored ? -1 : 1

    Rectangle
    {
      x: control.horizontal ? control.first.position * parent.width : (parent.width - width) / 2
      y: control.horizontal ? (parent.height - height) / 2 : control.second.visualPosition * parent.height
      width: control.horizontal ? control.second.position * parent.width - control.first.position * parent.width : 3
      height: control.horizontal ? 3 : control.second.position * parent.height - control.first.position * parent.height
      color: control.enabled ? control.accentColor : control.disabledColor
    } // Rectangle
  } // Rectangle
} // RangeSlider
