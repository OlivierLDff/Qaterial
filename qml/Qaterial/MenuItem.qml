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

T.MenuItem
{
  id: _control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    implicitContentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    implicitContentHeight + topPadding + bottomPadding)

  property bool drawline: Qaterial.Style.debug.drawDebugButton

  width: parent ? parent.width : 100

  Qaterial.DebugRectangle
  {
    anchors.fill: parent
    border.color: "pink"
    visible: _control.drawline
  } // DebugRectangle

  display: AbstractButton.TextBesideIcon

  topInset: Qaterial.Style.menuItem.topInset
  bottomInset: Qaterial.Style.menuItem.bottomInset
  leftInset: Qaterial.Style.menuItem.leftInset
  rightInset: Qaterial.Style.menuItem.rightInset

  leftPadding: (icon.source != "" && !mirrored || text == "" ? Qaterial.Style.menuItem.iconPadding : Qaterial.Style
    .menuItem.padding) + leftInset
  rightPadding: (icon.source != "" && mirrored || text == "" ? Qaterial.Style.menuItem.iconPadding : Qaterial.Style
    .menuItem.padding) + rightInset
  topPadding: 0
  bottomPadding: 0
  spacing: Qaterial.Style.menuItem.spacing

  property bool outlined: false

  property color foregroundColor: enabled ? (colorReversed ? Qaterial.Style.primaryTextColorReversed() : Qaterial
    .Style.primaryTextColor()) : (colorReversed ? Qaterial.Style.hintTextColorReversed() : Qaterial.Style
    .hintTextColor())

  property color backgroundColor: "transparent"

  property color rippleColor: Qaterial.Style.rippleColor(onPrimary ? Qaterial.Style.RippleBackground.Primary :
    Qaterial.Style.RippleBackground.Background)

  property bool onPrimary: false
  property bool colorReversed: onPrimary && Qaterial.Style.shouldReverseForegroundOnPrimary

  property double radius: Qaterial.Style.menuItem.cornerRadius

  property
  var checkedIcon: QtObject
  {
    readonly property double width: Qaterial.Style.menuItem.iconWidth
    readonly property double height: Qaterial.Style.menuItem.iconWidth
    readonly property color color: foregroundColor
    readonly property url source: Qaterial.Icons.check
  } // QtObject

  property
  var radioIcon: QtObject
  {
    readonly property double width: Qaterial.Style.menuItem.iconWidth
    readonly property double height: Qaterial.Style.menuItem.iconWidth
    readonly property color color: foregroundColor
    readonly property url source: _control.checked ? Qaterial.Icons.radioboxMarked : Qaterial.Icons.radioboxBlank
  } // QtObject

  icon.width: Qaterial.Style.menuItem.iconWidth
  icon.height: Qaterial.Style.menuItem.iconWidth
  icon.color: foregroundColor
  icon.source: checkable && checked ? Qaterial.Icons.check : ""

  property bool clipRipple: true
  property bool forceRipple: false
  property bool accentRipple: false

  indicator: Qaterial.Label
  {
    x: _control.mirrored ? _control.leftPadding : _control.width - width - _control.rightPadding
    y: _control.topPadding + (_control.availableHeight - height) / 2
    //width: _control.icon.width
    //height: _control.icon.height
    width: Qaterial.Style.menuItem.shortcutImplicitWidth
    text: _control.action && _control.action.shortcut ? _control.action.shortcut : ""
    visible: _control.action && _control.action.shortcut != ""
    horizontalAlignment: _control.mirrored ? Qt.AlignRight : Qt.AlignLeft
    textType: Qaterial.Style.TextType.MenuHint
    onPrimary: _control.onPrimary
    colorReversed: _control.colorReversed

    Qaterial.DebugRectangle
    {
      anchors.fill: parent
      border.color: "violet"
      visible: _control.drawline
    } // DebugRectangle
  } // Label

  arrow: Qaterial.ColorIcon
  {
    x: _control.mirrored ? _control.padding : _control.width - width - _control.padding
    y: _control.topPadding + (_control.availableHeight - height) / 2

    visible: _control.subMenu
    mirror: _control.mirrored
    color: _control.foregroundColor
    source: Qaterial.Icons.menuRight
  } // ColorIcon

  contentItem: Qaterial.IconLabel
  {
    id: _iconLabel

    readonly property real arrowPadding: _control.subMenu && _control.arrow ? _control.arrow.width + _control
      .spacing : 0
    readonly property real indicatorPadding: _control.indicator && _control.indicator.visible ? _control.indicator
      .width + _control.spacing : 0
    anchors.leftMargin: _control.mirrored ? indicatorPadding + arrowPadding : 0
    anchors.rightMargin: !_control.mirrored ? indicatorPadding + arrowPadding : 0

    alwaysRenderIcon: true

    alignment: Qt.AlignLeft
    elide: Text.ElideRight

    spacing: _control.spacing
    display: _control.display
    textType: Qaterial.Style.TextType.Menu
    icon: _control.icon
    text: _control.text
    color: _control.foregroundColor
  } // IconLabel

  property double backgroundImplicitWidth: Qaterial.Style.menuItem.minWidth
  property double backgroundImplicitHeight: Qaterial.Style.menuItem.minHeight

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
} // MenuItem
