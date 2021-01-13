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

Qaterial.RoundButton
{
  id: root

  property alias iconItem: _iconLabel.iconItem

  spacing: 4

  topInset: Qaterial.Style.toolButton.padding
  bottomInset: Qaterial.Style.toolButton.padding
  leftInset: Qaterial.Style.toolButton.padding
  rightInset: Qaterial.Style.toolButton.padding

  topPadding: Qaterial.Style.toolButton.padding * 2
  bottomPadding: Qaterial.Style.toolButton.padding * 1.5
  leftPadding: Qaterial.Style.toolButton.padding * 2
  rightPadding: Qaterial.Style.toolButton.padding * 2

  icon.width: Qaterial.Style.fab.iconWidth
  icon.height: Qaterial.Style.fab.iconWidth
  icon.color: Qaterial.Style.accentColor

  contentItem: Qaterial.IconLabel
  {
    id: _iconLabel
    iconItem: root.iconItem
    font: Qaterial.Style.textTheme.hint1
    display: Qaterial.IconLabel.TextUnderIcon
    spacing: root.spacing
    text: root.text
    icon.width: root.icon.width
    icon.height: root.icon.height
    icon.source: root.icon.source
    icon.color: root.icon.color
  }

  //  // fixme : herit from button with RoundButton with flat:true
  //  background: Item
  //  {
  //    implicitWidth: Qaterial.Style.toolButton.minWidth
  //    implicitHeight: Qaterial.Style.toolButton.minHeight
  //
  //    Qaterial.Ripple
  //    {
  //      id: _ripple
  //
  //      width: root.width
  //      height: root.height
  //
  //      anchors.centerIn: parent
  //
  //      pressed: root.pressed
  //      anchor: root
  //      active: root.down || root.visualFocus //|| root.hovered
  //
  //      color: Qaterial.Style.rippleColor(Qaterial.Style.RippleBackground.Background)
  //    } // Ripple
  //  }
} // Button
