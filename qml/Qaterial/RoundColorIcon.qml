/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

Qaterial.ColorIcon
{
  id: _root
  property bool highlighted: true
  property bool reverseHighlight: false
  property bool onPrimary: false
  property bool colorReversed: onPrimary && Qaterial.Style.shouldReverseForegroundOnPrimary
  property bool enabled: true

  iconSize: Qaterial.Style.roundIcon.iconWidth
  roundSize: Qaterial.Style.roundIcon.size

  width: roundSize
  height: roundSize

  roundOpacity: !(fill && highlighted && reverseHighlight) || !enabled

  color: enabled ? (fill && highlighted && reverseHighlight ? (Qaterial.Style.shouldReverseForegroundOnAccent ?
    Qaterial.Style.primaryTextColorReversed() : Qaterial.Style.primaryTextColor()) : (highlighted ? Qaterial.Style
    .accentColor : Qaterial.Style.primaryTextColor())) : (colorReversed ? Qaterial.Style
    .disabledTextColorReversed() : Qaterial.Style.disabledTextColor())

  roundColor: !fill ? "transparent" : enabled ?
    (highlighted && reverseHighlight ? Qaterial.Style.accentColor : (colorReversed ? Qaterial.Style
      .disabledDividersColorReversed() : Qaterial.Style.disabledDividersColor())) : (colorReversed ? Qaterial.Style
      .disabledDividersColorReversed() : Qaterial.Style.disabledDividersColor())

  roundBorderColor: !outlined ? "transparent" : enabled ?
    (highlighted && reverseHighlight ? Qaterial.Style.accentColor : (colorReversed ? Qaterial.Style
      .disabledDividersColorReversed() : Qaterial.Style.disabledDividersColor())) : (colorReversed ? Qaterial.Style
      .disabledDividersColorReversed() : Qaterial.Style.disabledDividersColor())
} // ColorIcon
