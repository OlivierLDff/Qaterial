/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12

// Qaterial
import Qaterial 1.0 as Qaterial

T.MenuBarItem
{
  id: _control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    implicitContentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    implicitContentHeight + topPadding + bottomPadding)

  property bool drawline: Qaterial.Style.debug.drawDebugButton

  Qaterial.DebugRectangle
  {
    anchors.fill: parent
    border.color: "pink"
    visible: _control.drawline
  }

  topInset: Qaterial.Style.menuBarItem.topInset
  bottomInset: Qaterial.Style.menuBarItem.bottomInset
  leftInset: Qaterial.Style.menuBarItem.leftInset
  rightInset: Qaterial.Style.menuBarItem.rightInset

  property alias textType: _iconLabel.textType

  leftPadding: (icon.source != "" && !mirrored || text == "" ? Qaterial.Style.menuBarItem.iconPadding : Qaterial.Style
    .menuBarItem.padding) + leftInset
  rightPadding: (icon.source != "" && mirrored || text == "" ? Qaterial.Style.menuBarItem.iconPadding : Qaterial.Style
    .menuBarItem.padding) + rightInset
  topPadding: 0
  bottomPadding: 0
  spacing: Qaterial.Style.menuBarItem.spacing

  property bool outlined: false

  property color foregroundColor: enabled ? (colorReversed ? Qaterial.Style.primaryTextColorReversed() : Qaterial
    .Style.primaryTextColor()) : (colorReversed ? Qaterial.Style.hintTextColorReversed() : hintTextColor
    .primaryTextColor())

  property color backgroundColor: "transparent"

  property color rippleColor: Qaterial.Style.rippleColor(onPrimary ? Qaterial.Style.RippleBackground.Primary :
    Qaterial.Style.RippleBackground.Background)

  property bool onPrimary: false
  property bool colorReversed: onPrimary && Qaterial.Style.shouldReverseForegroundOnPrimary

  property double radius: Qaterial.Style.menuBarItem.cornerRadius

  icon.width: Qaterial.Style.menuBarItem.iconWidth
  icon.height: Qaterial.Style.menuBarItem.iconWidth
  icon.color: foregroundColor

  property bool clipRipple: true
  property bool forceRipple: false
  property bool accentRipple: false

  contentItem: Qaterial.IconLabel
  {
    id: _iconLabel
    spacing: _control.spacing
    display: _control.display
    icon: _control.icon
    text: _control.text
    textType: Qaterial.Style.TextType.Menu
    color: _control.foregroundColor
  } // IconLabel

  property double backgroundImplicitWidth: Qaterial.Style.menuBarItem.minWidth
  property double backgroundImplicitHeight: Qaterial.Style.menuBarItem.minHeight

  focusPolicy: Qt.StrongFocus

  background: Rectangle
  {
    Qaterial.DebugRectangle
    {
      anchors.fill: parent
      border.color: "aquamarine"
      visible: _control.drawline
    } // DebugRectangle

    implicitWidth: _control.backgroundImplicitWidth
    implicitHeight: _control.backgroundImplicitHeight
    radius: _control.radius
    color: _control.backgroundColor

    Qaterial.Ripple
    {
      id: _ripple
      property bool isActive: _control.down || _control.visualFocus || _control.hovered || _control.forceRipple
      width: parent.width
      height: parent.height
      anchors.centerIn: parent
      pressed: _control.pressed
      anchor: _control
      active: isActive
      color: _control.rippleColor
      // trick because clipRadius isn't working in ripple private implementation (QTBUG-51894)
      layer.enabled: _control.clipRipple
      layer.effect: OpacityMask
      {
        maskSource: Rectangle
        {
          width: _ripple.width
          height: _ripple.height
          radius: _control.radius
        } // Rectangle
      } // OpacityMask
    } // Ripple
  } // Rectangle
} // MenuBarItem
