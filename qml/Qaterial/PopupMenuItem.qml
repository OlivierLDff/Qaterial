/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

 // Qt
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Templates 2.12 as T

// Qaterial
import Qaterial 1.0 as Qaterial

T.Button
{
  id: root

  property Component iconItem: Qaterial.Icon
  {
    icon: root.icon.source
    color: Qaterial.Style.accentColor
  }

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                          implicitContentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                           implicitContentHeight + topPadding + bottomPadding)

  topInset: Qaterial.Style.toolButton.padding
  bottomInset: Qaterial.Style.toolButton.padding
  leftInset: Qaterial.Style.toolButton.padding
  rightInset: Qaterial.Style.toolButton.padding

  leftPadding: 0
  rightPadding: 0

  icon.width: Qaterial.Style.fab.iconWidth
  icon.height: Qaterial.Style.fab.iconWidth

  contentItem: Item
  {
    implicitHeight: _icon.height

    Loader
    {
      id: _icon

      anchors.centerIn: parent
      anchors.verticalCenterOffset: -height/4

      width: root.icon.width
      height: root.icon.height

      sourceComponent: root.iconItem

      //Qaterial.DebugRectangle { anchors.fill: parent; border.color: Qaterial.Colors.green500 }
    }

    Qaterial.Label
    {
      anchors.top: _icon.bottom
      anchors.topMargin: 4
      anchors.horizontalCenter: parent.horizontalCenter

      width: parent.width

      text: root.text
      textType: Qaterial.Style.TextType.Hint
      elide: Text.ElideRight
      horizontalAlignment: Text.AlignHCenter

      //Qaterial.DebugRectangle { anchors.fill: parent; border.color: Qaterial.Colors.red500 }
    }

    // Qaterial.DebugRectangle { anchors.fill: parent }
  }

  background: Item
  {
    implicitWidth: Qaterial.Style.toolButton.minWidth
    implicitHeight: Qaterial.Style.toolButton.minHeight

    Qaterial.Ripple
    {
      id: _ripple

      width: root.width
      height: root.height

      anchors.centerIn: parent

      pressed: root.pressed
      anchor: root
      active: root.down || root.visualFocus //|| root.hovered

      color: Qaterial.Style.rippleColor(Qaterial.Style.RippleBackground.Background)
    } // Ripple
  }
} // Button
