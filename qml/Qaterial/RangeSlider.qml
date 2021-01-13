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
  property color color: Qaterial.Style.accentColor
  property color foregroundColor: Qaterial.Style.hintTextColor()
  property color disabledColor: Qaterial.Style.disabledTextColor()
  property color backgroundDisabledColor: Qaterial.Style.disabledDividersColor()

  first.handle: Qaterial.SliderHandle
  {
    x:
    {
      const horizontalOffset = control.first.visualPosition * (control.availableWidth - width)
      const verticalOffset = (control.availableWidth - width) / 2
      const offset = control.horizontal ? horizontalOffset : verticalOffset
      return control.leftPadding + offset
    }
    y:
    {
      const horizontalOffset = (control.availableHeight - height) / 2
      const verticalOffset = control.first.visualPosition * (control.availableHeight - height)
      const offset = control.horizontal ? horizontalOffset : verticalOffset
      return control.topPadding + offset
    }
    hasFocus: control.visualFocus
    hovered: control.first.hovered
    pressed: control.first.pressed
    rippleColor: control.rippleColor
    color: control.color
    disabledColor: control.disabledColor
    enabled: control.enabled
  } // SliderHandle

  second.handle: Qaterial.SliderHandle
  {
    x:
    {
      const horizontalOffset = control.second.visualPosition * (control.availableWidth - width)
      const verticalOffset = (control.availableWidth - width) / 2
      const offset = control.horizontal ? horizontalOffset : verticalOffset
      return control.leftPadding + offset
    }
    y:
    {
      const horizontalOffset = (control.availableHeight - height) / 2
      const verticalOffset = control.second.visualPosition * (control.availableHeight - height)
      const offset = control.horizontal ? horizontalOffset : verticalOffset
      return control.topPadding + offset
    }
    hasFocus: control.visualFocus
    hovered: control.second.hovered
    pressed: control.second.pressed
    rippleColor: control.rippleColor
    color: control.color
    disabledColor: control.disabledColor
    enabled: control.enabled
  } // SliderHandle

  property int backgroundImplicitWidth: horizontal ? Qaterial.Style.slider.implicitWidth : Qaterial.Style.slider
    .implicitHeight
  property int backgroundImplicitHeight: horizontal ? Qaterial.Style.slider.implicitHeight : Qaterial.Style.slider
    .implicitWidth

  background: Rectangle
  {
    readonly property int size: 1
    implicitWidth: control.backgroundImplicitWidth
    implicitHeight: control.backgroundImplicitHeight
    x:
    {
      const horizontalOffset = control.first.handle.width / 2
      const verticalOffset = (control.availableWidth - width) / 2
      const offset = control.horizontal ? horizontalOffset : verticalOffset
      return control.leftPadding + offset
    }
    y:
    {
      const horizontalOffset = (control.availableHeight - height) / 2
      const verticalOffset = control.first.handle.height / 2
      const offset = control.horizontal ? horizontalOffset : verticalOffset
      return control.topPadding + offset
    }
    width:
    {
      if(!control.horizontal)
        return size
      return control.availableWidth - control.first.handle.width / 2 - control.second.handle.width / 2
    }
    height:
    {
      if(control.horizontal)
        return size
      return control.availableHeight - control.first.handle.height / 2 - control.second.handle.height / 2
    }
    color: control.enabled ? control.foregroundColor : control.backgroundDisabledColor
    scale: control.horizontal && control.mirrored ? -1 : 1

    Rectangle
    {
      readonly property int size: 3
      x:
      {
        if(control.horizontal)
          return control.first.position * parent.width
        else
          return (parent.width - width) / 2
      }
      y:
      {
        if(control.horizontal)
          return (parent.height - height) / 2
        else
          return control.second.visualPosition * parent.height
      }
      width:
      {
        if(!control.horizontal)
          return size
        return control.second.position * parent.width - control.first.position * parent.width
      }
      height:
      {
        if(control.horizontal)
          return size
        return control.second.position * parent.height - control.first.position * parent.height
      }
      color: control.enabled ? control.color : control.disabledColor
    } // Rectangle
  } // Rectangle
} // RangeSlider
