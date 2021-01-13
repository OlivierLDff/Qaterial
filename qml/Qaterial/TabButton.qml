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
  id: _control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    implicitContentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    implicitContentHeight + topPadding + bottomPadding)

  leftPadding: ((icon.source != "" && !mirrored) ? Qaterial.Style.tabButton.iconPadding :
    Qaterial.Style.tabButton.padding) + leftInset
  rightPadding: ((icon.source != "" && mirrored) ? Qaterial.Style.tabButton.iconPadding :
    Qaterial.Style.tabButton.padding) + rightInset

  topInset: Qaterial.Style.tabButton.topInset
  bottomInset: Qaterial.Style.tabButton.bottomInset
  leftInset: Qaterial.Style.tabButton.leftInset
  rightInset: Qaterial.Style.tabButton.rightInset

  topPadding: Qaterial.Style.tabButton.topPadding
  bottomPadding: topPadding
  spacing: Qaterial.Style.tabButton.spacingVertical

  font: Qaterial.Style.textTheme.button

  icon.width: Qaterial.Style.tabButton.iconWidth
  icon.height: Qaterial.Style.tabButton.iconWidth
  icon.color: foregroundColor

  property color foregroundColor: !enabled ? (colorReversed ? Qaterial.Style.disabledTextColorReversed() : Qaterial
      .Style.disabledTextColor()) : (down || checked) ? (highlighted ? Qaterial.Style.buttonAccentColor : (
      colorReversed ? Qaterial.Style.primaryTextColorReversed() : Qaterial.Style.primaryTextColor())) : highlighted ?
    (colorReversed ? Qaterial.Style.primaryTextColorReversed() : Qaterial.Style.primaryTextColor()) : (colorReversed ?
      Qaterial.Style.secondaryTextColorReversed() : Qaterial.Style.secondaryTextColor())

  property color backgroundColor: pressed ? Qaterial.Style.backgroundColor :
    !enabled ? (Qaterial.Style.buttonDisabledColor) : (highlighted ? Qaterial.Style.buttonAccentColor : Qaterial.Style
      .buttonColor)

  property bool onPrimary: false
  property bool colorReversed: onPrimary && Qaterial.Style.shouldReverseForegroundOnPrimary
  property bool highlighted: onPrimary ? Qaterial.Style.preferAccentOnPrimary : true

  property color rippleColor: Qaterial.Style.rippleColor(onPrimary ? Qaterial.Style.RippleBackground.Primary :
    Qaterial.Style.RippleBackground.Background)

  display: AbstractButton.TextBesideIcon

  contentItem: Qaterial.IconLabel
  {
    id: _iconLabel
    font: _control.font
    spacing: _control.spacing
    display: _control.display
    icon.source: _control.icon.source
    icon.width: _control.icon.width
    icon.height: _control.icon.height
    icon.color: _control.icon.color
    icon.cache: _control.icon.cache
    text: _control.text
    color: _control.foregroundColor
  } // IconLabel

  background: Qaterial.Ripple
  {
    implicitWidth: Qaterial.Style.tabButton.minWidth
    implicitHeight: Qaterial.Style.tabButton.minHeight

    clip: true
    pressed: _control.pressed
    anchor: _control
    active: _control.down || _control.visualFocus || _control.hovered
    color: _control.rippleColor
  } // Ripple
} // TabButton
