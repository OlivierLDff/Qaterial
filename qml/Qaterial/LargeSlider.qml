/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

Qaterial.Slider
{
  id: control

  //Qaterial.DebugRectangle{ anchors.fill: parent }

  property int handleSize: 16

  readonly property int handleWidth: control.horizontal ? handleSize : availableWidth
  readonly property int handleHeight: control.horizontal ? availableHeight : handleSize

  property int radius: 4
  property int handleRadius: control.availableWidth / 2
  property int borderWidth: 2
  property int inlineBorderWidth: borderWidth * 2

  property color backgroundColor: "transparent"
  foregroundColor: hovered || pressed ? Qaterial.Style.secondaryTextColor() : Qaterial.Style.hintTextColor()

  implicitWidth: implicitBackgroundWidth + leftInset + rightInset
  implicitHeight: implicitBackgroundHeight + topInset + bottomInset

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
    borderColor: control.handleBorderColor
    disabledColor: control.disabledColor
    enabled: control.enabled
    clipRipple: true
    radius: control.handleRadius

    implicitWidth: control.handleWidth
    implicitHeight: control.handleHeight
    borderWidth: control.borderWidth

    rippleScaleFactor: 1
    pressedScaleFactor: 1.05
  } // SliderHandle

  background: Rectangle
  {
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
        return Math.max(control.handleWidth - control.handleHeight, control.handleWidth / 2, 8)
    }
    height:
    {
      if(control.horizontal)
        return Math.max(control.handleHeight - control.handleWidth, control.handleHeight / 2, 8)
      else
        return control.availableHeight - control.handle.height
    }

    color: control.enabled ? control.backgroundColor : control.backgroundDisabledColor
    border.color: control.foregroundColor
    border.width: control.borderWidth

    radius: control.radius

    // Indicate where the value is
    Rectangle
    {
      x:
      {
        if(control.horizontal)
          return control.borderWidth + control.inlineBorderWidth
        else
          return (parent.width - width) / 2
      }
      y:
      {
        if(control.horizontal)
          return (parent.height - height) / 2
        else
          return control.visualPosition * parent.height + control.borderWidth + control.inlineBorderWidth
      }

      width:
      {
        if(control.horizontal)
          return control.position * parent.width - control.borderWidth * 2 - control.inlineBorderWidth * 2
        else
          return parent.width - control.borderWidth * 2 - control.inlineBorderWidth * 2
      }

      height:
      {
        if(control.horizontal)
          return parent.height - control.borderWidth * 2 - control.inlineBorderWidth * 2
        else
          return control.position * parent.height - control.borderWidth * 2 - control.inlineBorderWidth * 2
      }
      color: control.enabled ? control.color : control.disabledColor

      radius: control.radius / 2
    } // Rectangle
  } // Rectangle
} // Slider
