/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Templates 2.12 as T
import QtGraphicalEffects 1.12

// Qaterial
import Qaterial 1.0 as Qaterial

T.TabButton
{
  id: control

  property color textColor: Qaterial.Style.primaryTextColor()
  property color textSecondaryColor: Qaterial.Style.secondaryTextColor()
  property color indicatorColor: Qaterial.Style.accentColor
  property color disabledTextColor: Qaterial.Style.disabledTextColor()
  property color rippleColor: Qaterial.Style.rippleColor(Qaterial.Style.RippleBackground.Background)
  property bool highlighted: ListView.isCurrentItem

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    implicitContentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    implicitContentHeight + topPadding + bottomPadding)

  leftPadding: Qaterial.Style.tabButton.padding + leftInset
  rightPadding: Qaterial.Style.tabButton.padding + rightInset

  topInset: Qaterial.Style.tabButton.topInset
  bottomInset: Qaterial.Style.tabButton.bottomInset
  leftInset: Qaterial.Style.tabButton.leftInset
  rightInset: Qaterial.Style.tabButton.rightInset

  topPadding: Qaterial.Style.tabButton.topPadding
  bottomPadding: Qaterial.Style.tabButton.topPadding

  font.family: "Lato"
  font.styleName: "Regular"
  font.bold: true

  contentItem: Qaterial.Label
  {
    id: _iconLabel
    textType: Qaterial.Style.TextType.ListText
    text: control.text
    font: control.font
    color:
    {
      if(!control.enabled)
        return control.disabledTextColor
      if(control.hovered || control.pressed || control.visualFocus || control.highlighted)
        return control.textColor
      return control.textSecondaryColor
    }
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
  } // IconLabel

  background: Qaterial.Ripple
  {
    implicitHeight: 48
    implicitWidth: Qaterial.Style.tabButton.minWidth
    clip: true
    pressed: control.pressed
    anchor: control
    active: control.visualFocus
    color: control.rippleColor
  } // Ripple

  indicator: Qaterial.SideSelectIndicator
  {
    x: (parent.width - width) / 2
    y: parent.height - thickness / 2

    horizontal: true

    active: control.down || control.visualFocus || control.hovered || control.highlighted
    pressed: control.pressed || control.highlighted
    hovered: control.hovered

    color: control.enabled ? control.indicatorColor : control.disabledTextColor

    indicatorClip: Qaterial.Style.Position.Bottom

    thickness: 6
    hoveredThickness: 24
    pressedThickness: control.width - control.leftPadding - control.rightPadding
  }
} // TabButton
