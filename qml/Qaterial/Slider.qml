/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Templates 2.12 as T

// Qaterial
import Qaterial 1.0 as Qaterial

T.Slider
{
  id: control

  padding: Qaterial.Style.slider.padding

  property color rippleColor: Qaterial.Style.rippleColorTheme
  property color color: Qaterial.Style.accentColor
  property color handleColor: color
  property color foregroundColor: Qaterial.Style.hintTextColor()
  property color disabledColor: Qaterial.Style.disabledTextColor()
  property color backgroundDisabledColor: Qaterial.Style.disabledDividersColor()
  property color handleBorderColor: Qaterial.Style.primaryTextColor()

  property int backgroundImplicitWidth: horizontal ? Qaterial.Style.slider.implicitWidth : Qaterial.Style.slider
    .implicitHeight
  property int backgroundImplicitHeight: horizontal ? Qaterial.Style.slider.implicitHeight : Qaterial.Style.slider
    .implicitWidth

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    implicitHandleWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    implicitHandleHeight + topPadding + bottomPadding)

  handle: Qaterial.SliderHandle
  {
    x:
    {
      const horizontalOffset = control.visualPosition * (control.availableWidth - width)
      const verticalOffset = (control.availableWidth - width) / 2
      const offset = control.horizontal ? horizontalOffset : verticalOffset
      return offset + control.leftPadding
    }
    y:
    {
      const horizontalOffset = (control.availableHeight - height) / 2
      const verticalOffset = control.visualPosition * (control.availableHeight - height)
      const offset = control.horizontal ? horizontalOffset : verticalOffset
      control.topPadding + offset
    }
    hasFocus: control.visualFocus
    pressed: control.pressed
    hovered: control.hovered
    rippleColor: control.rippleColor
    color: control.handleColor
    disabledColor: control.disabledColor
    borderColor: control.handleBorderColor
    enabled: control.enabled
  } // SliderHandle

  // Grey bar background
  background: Rectangle
  {
    readonly property int size: 1
    implicitWidth: control.backgroundImplicitWidth
    implicitHeight: control.backgroundImplicitHeight
    x:
    {
      const horizontalOffset = control.handle.width / 2
      const verticalOffset = (control.availableWidth - width) / 2
      const offset = control.horizontal ? horizontalOffset : verticalOffset
      return offset + control.leftPadding
    }
    y:
    {
      const horizontalOffset = (control.availableHeight - height) / 2
      const verticalOffset = control.handle.height / 2
      const offset = control.horizontal ? horizontalOffset : verticalOffset
      return control.topPadding + offset
    }
    width:
    {
      if(control.horizontal)
        return control.availableWidth - control.handle.width
      else
        return size
    }
    height:
    {
      if(control.horizontal)
        return size
      else
        return control.availableHeight - control.handle.height
    }
    color: control.enabled ? control.foregroundColor : control.backgroundDisabledColor
    scale: control.horizontal && control.mirrored ? -1 : 1

    // Accent bar going up to value
    Rectangle
    {
      readonly property int size: 3
      x:
      {
        if(control.horizontal)
          return 0
        else
          return (parent.width - width) / 2
      }
      y:
      {
        if(control.horizontal)
          return (parent.height - height) / 2
        else
          return control.visualPosition * parent.height
      }
      width:
      {
        if(control.horizontal)
          return control.position * parent.width
        else
          return size
      }
      height:
      {
        if(control.horizontal)
          return 3
        else
          return control.position * parent.height
      }
      color: control.enabled ? control.color : control.disabledColor
    } // Rectangle
  } // Rectangle
} // Slider
