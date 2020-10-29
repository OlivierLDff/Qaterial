/**
 * Copyright (C) Paul Cales 2020
 * Contact: cales.paul@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Templates 2.12 as T

// Qaterial
import Qaterial 1.0 as Qaterial

T.ToolTip
{

  id: control

  property double backgroundRadius: Qaterial.Style.toolTip.radius
  property int textType: Qaterial.Style.dense ? Qaterial.Style.TextType.Caption : Qaterial.Style.TextType.Body1

  property int position: Qaterial.Style.Position.Top

  x:
  {
    if(!parent) return 0;
    switch (position)
    {
      case Qaterial.Style.Position.BottomLeft:
      case Qaterial.Style.Position.TopLeft:
        return -width - margins / 2

      case Qaterial.Style.Position.BottomStart:
      case Qaterial.Style.Position.TopStart:
        return 0

      case Qaterial.Style.Position.Bottom:
      case Qaterial.Style.Position.Center:
      case Qaterial.Style.Position.Top:
        return (parent.width - width) / 2

      case Qaterial.Style.Position.BottomEnd:
      case Qaterial.Style.Position.TopEnd:
        return parent.width - width

      case Qaterial.Style.Position.BottomRight:
      case Qaterial.Style.Position.TopRight:
        return parent.width + margins / 2

      case Qaterial.Style.Position.RightStart:
      case Qaterial.Style.Position.Right:
      case Qaterial.Style.Position.RightEnd:
        return parent.width + margins / 2

      case Qaterial.Style.Position.LeftEnd:
      case Qaterial.Style.Position.Left:
      case Qaterial.Style.Position.LeftStart:
        return -width - margins / 2
    }
    Qaterial.Logger.warn(`Unknown Position : ${position}`)
    return 0;
  }

  y:
  {
    if(!parent) return 0;
    switch (position)
    {
      case Qaterial.Style.Position.TopLeft:
      case Qaterial.Style.Position.TopStart:
      case Qaterial.Style.Position.Top:
      case Qaterial.Style.Position.TopEnd:
      case Qaterial.Style.Position.TopRight:
        return -height - margins / 2

      case Qaterial.Style.Position.BottomLeft:
      case Qaterial.Style.Position.BottomStart:
      case Qaterial.Style.Position.Bottom:
      case Qaterial.Style.Position.BottomEnd:
      case Qaterial.Style.Position.BottomRight:
        return parent.height + margins / 2

      case Qaterial.Style.Position.RightStart:
      case Qaterial.Style.Position.LeftStart:
        return 0

      case Qaterial.Style.Position.Right:
      case Qaterial.Style.Position.Center:
      case Qaterial.Style.Position.Left:
        return (parent.height - height) / 2

      case Qaterial.Style.Position.RightEnd:
      case Qaterial.Style.Position.LeftEnd:
        return parent.height - height
    }
    Qaterial.Logger.warn(`Unknown Position : ${position}`)
    return -height - margins / 2;
  }

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    implicitContentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    implicitContentHeight + topPadding + bottomPadding)

  margins: 12
  horizontalPadding: Qaterial.Style.toolTip.padding
  verticalPadding: 0

  closePolicy: T.Popup.CloseOnEscape | T.Popup.CloseOnPressOutsideParent | T.Popup.CloseOnReleaseOutsideParent

  enter: Transition
  {
    // toast_enter
    NumberAnimation
    {
      property: "opacity";from: 0.0;to: 1.0;easing.type: Easing
        .OutQuad;duration: 100
    } // NumberAnimation
  } // Transition

  exit: Transition
  {
    // toast_exit
    NumberAnimation
    {
      property: "opacity";from: 1.0;to: 0.0;easing.type: Easing
        .InQuad;duration: 200
    } // NumberAnimation
  } // Transition

  contentItem: Qaterial.Label
  {
    text: control.text
    textType: control.textType
    color: Qaterial.Style.snackbarTextColor()
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter

    // Qaterial.DebugRectangle { anchors.fill: parent; border.color: "green" } // DebugRectangle
  } // Label

  background: Rectangle
  {
    implicitHeight: Qaterial.Style.toolTip.implicitHeight
    color: Qaterial.Style.snackbarColor()
    opacity: Qaterial.Style.toolTip.opacity
    radius: control.backgroundRadius

    // Qaterial.DebugRectangle { anchors.fill: parent; border.color: "pink" } // DebugRectangle
  } // Rectangle
} // ToolTip
