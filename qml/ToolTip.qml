
/**
 * Copyright (C) Paul Cales 2020
 * Contact: cales.paul@gmail.com
 */

 // Qt
import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls.Material 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

T.ToolTip
{

  id: _control

  property bool drawline: Qaterial.Style.debug.drawDebugButton

  x: parent ? (parent.width - implicitWidth) / 2 : 0
  y: -implicitHeight - 24

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                          implicitContentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                           implicitContentHeight + topPadding + bottomPadding)

  margins: 12
  padding: 8
  horizontalPadding: padding + 8

  closePolicy: T.Popup.CloseOnEscape | T.Popup.CloseOnPressOutsideParent | T.Popup.CloseOnReleaseOutsideParent

  Material.theme: Material.Dark

  enter: Transition
  {
    // toast_enter
    NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; easing.type: Easing.OutQuad; duration: 500 } // NumberAnimation
  } // Transition

  exit: Transition
  {
    // toast_exit
    NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; easing.type: Easing.InQuad; duration: 500 } // NumberAnimation
  } // Transition

  contentItem: Qaterial.Label
  {
    text: _control.text
    font: _control.font
    wrapMode: Text.Wrap
    color: _control.Material.foreground
    horizontalAlignment: Text.AlignHCenter

    Qaterial.DebugRectangle
    {
      anchors.fill: parent
      border.color: "green"
      visible: _control.drawline
    } // DebugRectangle
  } // Label

  background: Rectangle
  {
    implicitHeight: _control.Material.tooltipHeight
    color: _control.Material.tooltipColor
    opacity: 0.9
    radius: 2
    Qaterial.DebugRectangle
    {
      anchors.fill: parent
      border.color: "pink"
      visible: _control.drawline
    } // DebugRectangle
  } // Rectangle
} // ToolTip
