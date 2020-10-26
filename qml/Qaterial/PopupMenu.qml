import QtQuick 2.12
import QtQuick.Controls 2.12

import Qaterial 1.0 as Qaterial

Qaterial.Popup
{
  id: root

  parent: Overlay.overlay

  spacing: 8
  padding: 4

  property int _arrowOrigin

  function openAt(origin, transformOrigin)
  {
    root.transformOrigin = transformOrigin
    root._arrowOrigin = transformOrigin

    if(transformOrigin === Item.Top || transformOrigin === Item.Bottom)
      x = origin.x - implicitWidth / 2
    else if(transformOrigin === Item.Left)
      x = origin.x + spacing
    else
      x = origin.x - implicitWidth - spacing

    if(transformOrigin === Item.Left || transformOrigin === Item.Right)
      y = origin.y - implicitHeight / 2
    else if(transformOrigin === Item.Top)
      y = origin.y + spacing
    else
      y = origin.y - implicitHeight - spacing

    open()
  }

  background: Item
  {
    implicitWidth: 50
    implicitHeight: Qaterial.Style.menu.implicitHeight

    Rectangle
    {
      anchors.fill: parent

      radius: 4
      color: Qaterial.Style.dialogColor

      layer.enabled: true
      layer.effect: Qaterial.ElevationEffect
      {
        elevation: Qaterial.Style.menu.elevation
      } // ElevationEffect
    }

    Rectangle
    {
      x:
      {
        if(root._arrowOrigin === Item.Top || root._arrowOrigin === Item.Bottom)
          return (parent.width - width) / 2
        else if(root._arrowOrigin === Item.Left)
          return -width / 2
        else
          return parent.width - width / 2
      }
      y:
      {
        if(root._arrowOrigin === Item.Left || root._arrowOrigin === Item.Right)
          return (parent.height - height) / 2
        else if(root._arrowOrigin === Item.Top)
          return -height / 2
        else
          return parent.height - height / 2
      }
      width: 8
      height: 8
      rotation: 45
      color: Qaterial.Style.dialogColor
    } // Triangle
  } // Rectangle

  enter: Transition
  {
    NumberAnimation { property: "scale";from: 0.0;to: 1.0;easing.type: Easing
    .OutQuint;duration: 220 } // NumberAnimation
    NumberAnimation { property: "opacity";from: 0.0;to: 1.0;easing.type: Easing
    .OutCubic;duration: 150 } // NumberAnimation
  } // Transition

  exit: Transition
  {
    NumberAnimation { property: "scale";from: 1.0;to: 0.0;easing.type: Easing
    .OutQuint;duration: 220 } // NumberAnimation
    NumberAnimation { property: "opacity";from: 1.0;to: 0.0;easing.type: Easing
    .OutCubic;duration: 150 } // NumberAnimation
  } // Transition
}
