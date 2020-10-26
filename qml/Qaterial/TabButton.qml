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

  topPadding: useSmallFont ? Qaterial.Style.tabButton.smallTopPadding : Qaterial.Style.tabButton.topPadding
  bottomPadding: topPadding
  spacing: display === AbstractButton.TextUnderIcon ? (useSmallFont ? Qaterial.Style.tabButton.smallSpacingVertical :
    Qaterial.Style.tabButton.spacingVertical) : (useSmallFont ? Qaterial.Style.tabButton.smallSpacing : Qaterial
    .Style.tabButton.spacing)

  font.family: Qaterial.Style.textTypeToFontFamily(Qaterial.Style.TextType.Button)
  font.styleName: Qaterial.Style.textTypeToStyleName(Qaterial.Style.TextType.Button)
  font.pixelSize: useSmallFont ? Qaterial.Style.textTypeToPixelSize(Qaterial.Style.TextType.Hint) : Qaterial.Style
    .textTypeToPixelSize(Qaterial.Style.TextType.Button)
  font.capitalization: Qaterial.Style.fontCapitalization(Qaterial.Style.TextType.Button)
  font.letterSpacing: Qaterial.Style.textTypeToLetterSpacing(Qaterial.Style.TextType.Button)

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
  property bool useSmallFont: hintText
  property bool hintText: false

  property alias elide: _iconLabel.elide

  property color rippleColor: Qaterial.Style.rippleColor(onPrimary ? Qaterial.Style.RippleBackground.Primary :
    Qaterial.Style.RippleBackground.Background)

  display: hintText && !checked ? AbstractButton.IconOnly : AbstractButton.TextUnderIcon

  contentItem: Qaterial.IconLabel
  {
    id: _iconLabel
    textType: Qaterial.Style.TextType.Button
    spacing: _control.spacing
    mirrored: _control.mirrored
    display: _control.display
    icon: _control.icon
    text: _control.text
    font: _control.font
    color: _control.foregroundColor
  } // IconLabel

  background: Qaterial.Ripple
  {
    implicitHeight: (_control.icon.source != "" &&
        _control.text != "" &&
        _control.display === AbstractButton.TextUnderIcon &&
        !_control.useSmallFont) ?
      Qaterial.Style.tabButton.minHeightWithIcon : _control.useSmallFont ? Qaterial.Style.tabButton
      .minHeightWithSmallIcon : Qaterial.Style.tabButton.minHeight

    implicitWidth: Qaterial.Style.tabButton.minWidth
    clip: true
    pressed: _control.pressed
    anchor: _control
    active: _control.down || _control.visualFocus || _control.hovered
    color: _control.rippleColor
  } // Ripple
} // TabButton
