/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

Rectangle
{
  implicitWidth: Qaterial.Style.menu.separatorImplicitWidth
  implicitHeight: 1
  property bool enabled: true
  color: !enabled ? (colorReversed ? Qaterial.Style.disabledDividersColorReversed() : Qaterial.Style
      .disabledDividersColor()) : highlighted && accentColorAuthorized ? Qaterial.Style.accentColor : colorReversed ?
    Qaterial.Style.dividersColorReversed() : Qaterial.Style.dividersColor()

  property bool highlighted: false
  property bool onPrimary: false
  property bool colorReversed: onPrimary && Qaterial.Style.shouldReverseForegroundOnPrimary
  property bool accentColorAuthorized: onPrimary && Qaterial.Style.preferAccentOnPrimary
} // Rectangle
