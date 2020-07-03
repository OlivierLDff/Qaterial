
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

  property bool drawline: Qaterial.Style.debug.drawDebugButton
  property double backgroupRadius: Qaterial.Style.toolTip.radius
  property int textType: Qaterial.Style.dense ? Qaterial.Style.TextType.Caption : Qaterial.Style.TextType.Body1

  x: parent ? (parent.width - width) / 2 : 0
  y: -height - margins/2

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
    NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; easing.type: Easing.OutQuad; duration: 100 } // NumberAnimation
  } // Transition

  exit: Transition
  {
    // toast_exit
    NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; easing.type: Easing.InQuad; duration: 200 } // NumberAnimation
  } // Transition

  contentItem: Qaterial.Label
  {
    text: control.text
    wrapMode: Text.Wrap
    color: Qaterial.Style.snackbarTextColor()
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    textType: control.textType

    // Qaterial.DebugRectangle { anchors.fill: parent; border.color: "green"; visible: control.drawline } // DebugRectangle
  } // Label

  background: Rectangle
  {
    implicitHeight: Qaterial.Style.toolTip.implicitHeight
    color: Qaterial.Style.snackbarColor()
    opacity: Qaterial.Style.toolTip.opacity
    radius: control.backgroupRadius

    // Qaterial.DebugRectangle { anchors.fill: parent; border.color: "pink"; visible: control.drawline } // DebugRectangle
  } // Rectangle
} // ToolTip
