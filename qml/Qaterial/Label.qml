/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.0
import QtQuick.Templates 2.0 as T
import QtQuick.Controls 2.0

// Qaterial
import Qaterial 1.0 as Qaterial

T.Label
{
  id: root

  font
  {
    family: _deprecatedFont.family
    pixelSize: _deprecatedFont.pixelSize
    weight: _deprecatedFont.weight
    capitalization: _deprecatedFont.capitalization
    letterSpacing: _deprecatedFont.letterSpacing
  }

  color:
  {
    if(enabled)
      return colorReversed ? Qaterial.Style.textTypeToColorReversed(textType) : Qaterial.Style.textTypeToColor(
        textType)
    return Qaterial.Style.hintTextColor()
  }
  linkColor: Qaterial.Style.accentColor

  property int textType: -1 // Qaterial.Style.TextType.Body1
  property bool onPrimary: false
  property bool colorReversed: onPrimary && Qaterial.Style.shouldReverseForegroundOnPrimary
  property bool usePixelSize: Qaterial.Style.usePixelSize

  readonly property font _deprecatedFont:
  {
    if(textType < 0)
      return Qaterial.Style.textTheme.body2

    console.warn("Qaterial.Style.TextType is deprecated. Please consider using either Qaterial.Style.textTheme or Qaterial.Label<Style>.\nQaterial.Style.TextType will be removed with Qaterial 1.4")

    switch (textType)
    {
      case Qaterial.Style.TextType.Display3:
        return Qaterial.Style.textTheme.headline2
      case Qaterial.Style.TextType.Display2:
        return Qaterial.Style.textTheme.headline3
      case Qaterial.Style.TextType.Display1:
        return Qaterial.Style.textTheme.headline4
      case Qaterial.Style.TextType.Heading:
        return Qaterial.Style.textTheme.headline5
      case Qaterial.Style.TextType.Title:
        return Qaterial.Style.textTheme.headline6
      case Qaterial.Style.TextType.Subheading:
        return Qaterial.Style.textTheme.subtitle1
      case Qaterial.Style.TextType.ListText:
        return Qaterial.Style.textTheme.body1
      case Qaterial.Style.TextType.ListSecText:
        return Qaterial.Style.textTheme.body2
      case Qaterial.Style.TextType.Overline:
        return Qaterial.Style.textTheme.overline
      case Qaterial.Style.TextType.Body2:
        return Qaterial.Style.textTheme.body1
      case Qaterial.Style.TextType.Body1:
        return Qaterial.Style.textTheme.body2
      case Qaterial.Style.TextType.Caption:
        return Qaterial.Style.textTheme.caption
      case Qaterial.Style.TextType.Hint:
        return Qaterial.Style.textTheme.hint1
      case Qaterial.Style.TextType.Button:
        return Qaterial.Style.textTheme.button
      case Qaterial.Style.TextType.Menu:
        return Qaterial.Style.textTheme.body2
      case Qaterial.Style.TextType.MenuHint:
        return Qaterial.Style.textTheme.hint2
      default:
        return Qaterial.Style.textTheme.body2
    }
  }

  //property double pixelSize: Qaterial.Style.textTypeToPixelSize(textType)
  //property double pointSize: Qaterial.Style.textTypeToPointSize(textType)

  //Binding on font.pixelSize
  //{
  //  when: root.usePixelSize
  //  value: root.pixelSize
  //} // Biding

  //Binding on font.pointSize
  //{
  //  when: !root.usePixelSize
  //  value: root.pointSize
  //} // Biding

  //font.family: Qaterial.Style.textTypeToFontFamily(textType)
  //font.styleName: Qaterial.Style.textTypeToStyleName(textType)
  //font.capitalization: Qaterial.Style.fontCapitalization(textType)
  //font.letterSpacing: Qaterial.Style.textTypeToLetterSpacing(textType)
} // Label
