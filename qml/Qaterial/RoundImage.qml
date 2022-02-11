/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick
import Qt5Compat.GraphicalEffects

// Qaterial
import Qaterial as Qaterial

Image
{
  id: _root
  fillMode: Image.PreserveAspectFit

  sourceSize.width: width
  sourceSize.height: height

  property bool rounded: true

  layer.enabled: rounded
  layer.effect: OpacityMask
  {
    maskSource: Rectangle
    {
      width: _root.width
      height: _root.height
      radius: _root.width / 2
    } // Rectangle
  } // OpacityMask
} // Image
