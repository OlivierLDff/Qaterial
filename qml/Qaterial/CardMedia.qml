/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtGraphicalEffects 1.12

// Qaterial
import Qaterial 1.0 as Qaterial

Image
{
  id: _control
  height: Qaterial.Style.card.mediaImplicitHeight
  width: Qaterial.Style.card.mediaImplicitWidth
  fillMode: Image.PreserveAspectCrop

  property bool clipTop: false
  property double radius: Qaterial.Style.card.radius

  layer.enabled: clipTop
  layer.effect: OpacityMask
  {
    maskSource: Rectangle
    {
      width: _control.width
      height: _control.height
      radius: _control.radius

      Rectangle
      {
        width: parent.width
        y: _control.radius
        height: parent.height - radius
      } // Rectangle
    } // Rectangle
  } // OpacityMask

  /*Qaterial.DebugRectangle
  {
      anchors.fill: _control
      border.color: "blue"
      z: 10
  } // DebugRectangle*/
} // Image
