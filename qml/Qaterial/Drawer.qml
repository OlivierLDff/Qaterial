/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Templates 2.12 as T

// Qaterial
import Qaterial 1.0 as Qaterial

T.Drawer
{
  id: _control

  parent: T.Overlay.overlay

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    contentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    contentHeight + topPadding + bottomPadding)

  topPadding: !dim && edge === Qt.BottomEdge && elevation === 0
  leftPadding: !dim && edge === Qt.RightEdge && elevation === 0
  rightPadding: !dim && edge === Qt.LeftEdge && elevation === 0
  bottomPadding: !dim && edge === Qt.TopEdge && elevation === 0

  enter: Transition { SmoothedAnimation { velocity: 5 } }
  exit: Transition { SmoothedAnimation { velocity: 5 } }

  property double elevation: (!interactive && !dim) ? 0 : 16
  property color backgroundColor: Qaterial.Style.dialogColor
  property color dividerColor: Qaterial.Style.dividersColor()
  property color overlayColor: Qaterial.Style.overlayColor

  background: Rectangle
  {
    color: _control.backgroundColor

    Rectangle
    {
      readonly property bool horizontal: _control.edge === Qt.LeftEdge || _control.edge === Qt.RightEdge
      width: horizontal ? 1 : parent.width
      height: horizontal ? parent.height : 1
      color: _control.dividerColor
      x: (_control.edge === Qt.LeftEdge) ? parent.width - 1 : 0
      y: (_control.edge === Qt.TopEdge) ? parent.height - 1 : 0
      visible: !_control.dim && _control.elevation === 0
    } // Rectangle

    layer.enabled: _control.position > 0
    layer.effect: Qaterial.ElevationEffect
    {
      elevation: _control.elevation
      fullHeight: true
    } // ElevationEffect
  } // Rectangle

  T.Overlay.modal: Rectangle
  {
    color: _control.overlayColor
    Behavior on opacity { NumberAnimation { duration: 150 } }
  } // Rectangle

  T.Overlay.modeless: Rectangle
  {
    color: _control.overlayColor
    Behavior on opacity { NumberAnimation { duration: 150 } }
  } // Rectangle
} // Drawer
