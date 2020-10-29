/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

T.Label
{
  id: _control

  color:
  {
    if(enabled)
      return colorReversed ? Qaterial.Style.textTypeToColorReversed(textType) : Qaterial.Style.textTypeToColor(
        textType)
    return Qaterial.Style.hintTextColor()
  }
  linkColor: Qaterial.Style.accentColor

  property int textType: Qaterial.Style.TextType.Body1
  property bool onPrimary: false
  property bool colorReversed: onPrimary && Qaterial.Style.shouldReverseForegroundOnPrimary
  property bool usePixelSize: Qaterial.Style.usePixelSize

  property double pixelSize: Qaterial.Style.textTypeToPixelSize(textType)
  property double pointSize: Qaterial.Style.textTypeToPointSize(textType)

  Binding on font.pixelSize
  {
    when: _control.usePixelSize
    value: _control.pixelSize
  } // Biding

  Binding on font.pointSize
  {
    when: !_control.usePixelSize
    value: _control.pointSize
  } // Biding

  font.family: Qaterial.Style.textTypeToFontFamily(textType)
  font.styleName: Qaterial.Style.textTypeToStyleName(textType)
  font.capitalization: Qaterial.Style.fontCapitalization(textType)
  font.letterSpacing: Qaterial.Style.textTypeToLetterSpacing(textType)
} // Label
