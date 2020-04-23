/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

import Qaterial 1.0 as Qaterial

Qaterial.RawMaterialButton
{
  flat: true
  highlighted: checked

  icon.width: Qaterial.Style.toolButton.iconWidth
  icon.height: Qaterial.Style.toolButton.iconWidth

  topInset: Qaterial.Style.toolButton.topInset
  bottomInset: Qaterial.Style.toolButton.bottomInset
  leftInset: Qaterial.Style.toolButton.leftInset
  rightInset: Qaterial.Style.toolButton.rightInset

  leftPadding: 0
  rightPadding: 0

  backgroundImplicitWidth: Qaterial.Style.toolButton.minWidth
  backgroundImplicitHeight: Qaterial.Style.toolButton.minHeight

  property bool onPrimary: false
  property bool colorReversed: onPrimary && Qaterial.Style.shouldReverseForegroundOnPrimary
  property bool useSecondaryColor: false

  readonly property bool accentColorAuthorized: (onPrimary && Qaterial.Style.preferAccentOnPrimary || !onPrimary)

  foregroundColor: !enabled ? (colorReversed ? Qaterial.Style.disabledTextColorReversed() : Qaterial.Style.disabledTextColor()) :
                  highlighted && accentColorAuthorized ? Qaterial.Style.accentColor :
                  !highlighted && !accentColorAuthorized || useSecondaryColor ? (colorReversed ? Qaterial.Style.secondaryTextColorReversed() : Qaterial.Style.secondaryTextColor()) :
                  colorReversed ? Qaterial.Style.primaryTextColorReversed() : Qaterial.Style.primaryTextColor()
} // RawMaterialButton
