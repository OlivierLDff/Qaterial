/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Templates 2.12 as T
import QtGraphicalEffects 1.12

import Qaterial 1.0 as Qaterial

T.Button
{
  id: root

  property bool showName: true
  property bool showShade: true

  property color color
  property string name
  property string shade

  property bool light: color.hslLightness > 0.65

  implicitWidth: 24
  implicitHeight: 24

  contentItem: Item
  {
    visible: (width > 32) &&
      (height > 24) && (root.showName || root.showShade)

    Column
    {
      id: _column

      anchors.margins: 4
      anchors.left: parent.left
      anchors.right: parent.right
      anchors.bottom: parent.bottom

      Qaterial.Label
      {
        visible: root.showName
        width: parent.width
        elide: Text.ElideRight
        text: root.name
        textType: Qaterial.Style.TextType.Caption
        color: root.light ? Qaterial.Style.primaryTextColorLight : Qaterial.Style.primaryTextColorDark
      }

      Qaterial.Label
      {
        visible: root.showShade
        width: parent.width
        text: root.shade
        textType: Qaterial.Style.TextType.Hint
        color: root.light ? Qaterial.Style.secondaryTextColorLight : Qaterial.Style.secondaryTextColorDark
      }
    }
  }

  background: Rectangle
  {
    readonly property bool enabled: (root.pressed || root.visualFocus || root.highlighted) && root.enabled

    border.width: enabled ? 2 : 1
    border.color:
    {
      if(root.light)
        return enabled ? Qaterial.Colors.gray800 : Qt.darker(color, 1.1)
      return enabled ? Qaterial.Colors.white : Qt.lighter(color, 1.25)
    }

    color: root.color

    Qaterial.Ripple
    {
      id: _ripple

      anchors.fill: parent

      pressed: root.pressed
      anchor: root
      active: root.down || root.visualFocus || root.hovered
      color: root.light ? Qaterial.Style.rippleColorDark : Qaterial.Style.rippleColorLight

      layer.enabled: root.enabled
      layer.effect: OpacityMask
      {
        maskSource: Rectangle
        {
          width: _ripple.width
          height: _ripple.height
        } // Rectangle
      } // OpacityMask
    } // Ripple
  }
}
