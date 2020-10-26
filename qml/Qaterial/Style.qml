/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

pragma Singleton

// Qt
import QtQuick 2.12
import QtQuick.Controls 2.12

// Qaterial
import Qaterial 1.0

QtObject
{
  id: _root

  enum Theme
  {
    Light,
    Dark
  }

  property int theme: Style.Theme.Dark
  property bool dense: false
  readonly property bool isDark: Style.theme === Style.Theme.Dark

  property bool foregroundReversedOnPrimaryLight: true
  property bool foregroundReversedOnPrimaryDark: false

  property bool rippleReversedOnPrimaryLight: true
  property bool rippleReversedOnPrimaryDark: false

  property bool foregroundReversedOnAccentLight: true
  property bool foregroundReversedOnAccentDark: false

  property bool preferAccentOnPrimaryLight: false
  property bool preferAccentOnPrimaryDark: true

  property bool shouldReverseForegroundOnPrimary: theme === Style.Theme.Light ? foregroundReversedOnPrimaryLight :
    foregroundReversedOnPrimaryDark
  property bool shouldReverseRippleOnPrimary: theme === Style.Theme.Light ? rippleReversedOnPrimaryLight :
    rippleReversedOnPrimaryDark
  property bool shouldReverseForegroundOnAccent: theme === Style.Theme.Light ? foregroundReversedOnAccentLight :
    foregroundReversedOnAccentDark
  property bool preferAccentOnPrimary: theme === Style.Theme.Light ? preferAccentOnPrimaryLight :
    preferAccentOnPrimaryDark

  property color primaryColorLight: "white"
  property color primaryColorDark: "#202225" //"#212121"
  property color accentColorLight: "#FFC107"
  property color accentColorDark: "#FFB835"
  property color backgroundColorLight: "#FFFFFF"
  property color backgroundColorDark: "#2F3136" //"#303030"
  property color foregroundColorLight: "#000000"
  property color foregroundColorDark: "#FFFFFF"

  property color blueGrey: "#607D8B"
  property color grey: "#9E9E9E"
  property color brown: "#795548"
  property color deepOrange: "#FF5722"
  property color orange: "#FF9800"
  property color amber: "#FFC107"
  property color yellow: "#FFEB3B"
  property color lime: "#8BC34A"
  property color green: "#4CAF50"
  property color teal: "#009688"
  property color cyan: "#00BCD4"
  property color lightBlue: "#03A9F4"
  property color blue: "#2196F3"
  property color indigo: "#3F51B5"
  property color deepPurple: "#673AB7"
  property color purple: "#9C27B0"
  property color pink: "#E91E63"
  property color red: "#f44336"

  property color primaryColor: theme === Style.Theme.Light ? primaryColorLight : primaryColorDark
  property color accentColor: theme === Style.Theme.Light ? accentColorLight : accentColorDark
  property color backgroundColor: theme === Style.Theme.Light ? backgroundColorLight : backgroundColorDark
  property color foregroundColor: theme === Style.Theme.Light ? foregroundColorLight : foregroundColorDark

  property color textColorLight: foregroundColorLight
  property color textColorDark: foregroundColorDark
  property color textColor: theme === Style.Theme.Light ? textColorLight : textColorDark
  property color errorColor: "#f44336"

  property double primaryTextColorRatioLight: 0.87
  property double displayTextColorRatioLight: 0.65
  property double secondaryTextColorRatioLight: 0.54
  property double disabledTextColorRatioLight: 0.38
  property double hintTextColorRatioLight: 0.38
  property double iconColorRatioLight: 0.38
  property double helperTextColorRatioLight: 0.38
  property double dividersColorRatioLight: 0.23
  property double disabledDividersColorRatioLight: 0.12
  property double errorTextColorRatioLight: 1.00

  property double primaryTextColorRatioDark: 1.00
  property double displayTextColorRatioDark: 0.70
  property double secondaryTextColorRatioDark: 0.70
  property double disabledTextColorRatioDark: 0.50
  property double hintTextColorRatioDark: 0.50
  property double iconColorRatioDark: 0.50
  property double helperTextColorRatioDark: 0.50
  property double dividersColorRatioDark: 0.20
  property double disabledDividersColorRatioDark: 0.12
  property double errorTextColorRatioDark: 1.00

  property color primaryTextColorLight: Qt.rgba(textColorLight.r, textColorLight.g, textColorLight.b,
    primaryTextColorRatioLight)
  property color displayTextColorLight: Qt.rgba(textColorLight.r, textColorLight.g, textColorLight.b,
    displayTextColorRatioLight)
  property color secondaryTextColorLight: Qt.rgba(textColorLight.r, textColorLight.g, textColorLight.b,
    secondaryTextColorRatioLight)
  property color disabledTextColorLight: Qt.rgba(textColorLight.r, textColorLight.g, textColorLight.b,
    disabledTextColorRatioLight)
  property color hintTextColorLight: Qt.rgba(textColorLight.r, textColorLight.g, textColorLight.b,
    hintTextColorRatioLight)
  property color iconColorLight: Qt.rgba(textColorLight.r, textColorLight.g, textColorLight.b, iconColorRatioLight)
  property color helperTextColorLight: Qt.rgba(textColorLight.r, textColorLight.g, textColorLight.b,
    helperTextColorRatioLight)
  property color dividersColorLight: Qt.rgba(textColorLight.r, textColorLight.g, textColorLight.b,
    dividersColorRatioLight)
  property color disabledDividersColorLight: Qt.rgba(textColorLight.r, textColorLight.g, textColorLight.b,
    disabledDividersColorRatioLight)
  property color errorTextColorLight: Qt.rgba(errorColor.r, errorColor.g, errorColor.b, errorTextColorRatioLight)

  property color primaryTextColorDark: Qt.rgba(textColorDark.r, textColorDark.g, textColorDark.b,
    primaryTextColorRatioDark)
  property color displayTextColorDark: Qt.rgba(textColorDark.r, textColorDark.g, textColorDark.b,
    displayTextColorRatioDark)
  property color secondaryTextColorDark: Qt.rgba(textColorDark.r, textColorDark.g, textColorDark.b,
    secondaryTextColorRatioDark)
  property color disabledTextColorDark: Qt.rgba(textColorDark.r, textColorDark.g, textColorDark.b,
    disabledTextColorRatioDark)
  property color hintTextColorDark: Qt.rgba(textColorDark.r, textColorDark.g, textColorDark.b, hintTextColorRatioDark)
  property color iconColorDark: Qt.rgba(textColorDark.r, textColorDark.g, textColorDark.b, iconColorRatioDark)
  property color helperTextColorDark: Qt.rgba(textColorDark.r, textColorDark.g, textColorDark.b,
    helperTextColorRatioDark)
  property color dividersColorDark: Qt.rgba(textColorDark.r, textColorDark.g, textColorDark.b, dividersColorRatioDark)
  property color disabledDividersColorDark: Qt.rgba(textColorDark.r, textColorDark.g, textColorDark.b,
    disabledDividersColorRatioDark)
  property color errorTextColorDark: Qt.rgba(errorColor.r, errorColor.g, errorColor.b, errorTextColorRatioDark)

  function primaryTextColor() { return theme === Style.Theme.Light ? primaryTextColorLight : primaryTextColorDark }

  function displayTextColor() { return theme === Style.Theme.Light ? displayTextColorLight : displayTextColorDark }

  function secondaryTextColor() { return theme === Style.Theme.Light ? secondaryTextColorLight :
    secondaryTextColorDark }

  function disabledTextColor() { return theme === Style.Theme.Light ? disabledTextColorLight : disabledTextColorDark }

  function hintTextColor() { return theme === Style.Theme.Light ? hintTextColorLight : hintTextColorDark }

  function iconColor() { return theme === Style.Theme.Light ? iconColorLight : iconColorDark }

  function helperTextColor() { return theme === Style.Theme.Light ? helperTextColorLight : helperTextColorDark }

  function dividersColor() { return theme === Style.Theme.Light ? dividersColorLight : dividersColorDark }

  function disabledDividersColor() { return theme === Style.Theme.Light ? disabledDividersColorLight :
      disabledDividersColorDark }

  function errorTextColor() { return theme === Style.Theme.Light ? errorTextColorLight : errorTextColorDark }

  function primaryTextColorReversed() { return theme != Style.Theme.Light ? primaryTextColorLight :
    primaryTextColorDark }

  function displayTextColorReversed() { return theme != Style.Theme.Light ? displayTextColorLight :
    displayTextColorDark }

  function secondaryTextColorReversed() { return theme != Style.Theme.Light ? secondaryTextColorLight :
      secondaryTextColorDark }

  function disabledTextColorReversed() { return theme != Style.Theme.Light ? disabledTextColorLight :
      disabledTextColorDark }

  function hintTextColorReversed() { return theme != Style.Theme.Light ? hintTextColorLight : hintTextColorDark }

  function iconColorReversed() { return theme != Style.Theme.Light ? iconColorLight : iconColorDark }

  function helperTextColorReversed() { return theme != Style.Theme.Light ? helperTextColorLight : helperTextColorDark }

  function dividersColorReversed() { return theme != Style.Theme.Light ? dividersColorLight : dividersColorDark }

  function disabledDividersColorReversed() { return theme != Style.Theme.Light ? disabledDividersColorLight :
      disabledDividersColorDark }

  function errorTextColorReversed() { return theme != Style.Theme.Light ? errorTextColorLight : errorTextColorDark }

  property color appBarColor: primaryColor
  property color dialogColor: Qt.lighter(backgroundColor, 1.375)
  property color cardColor: theme === Style.Theme.Light ? backgroundColor : Qt.lighter(backgroundColor, 1.375)
  property color cardBackgroundColor: theme === Style.Theme.Light ? Qt.darker(backgroundColor, 1.25) : backgroundColor
  property color paneColor: Qt.lighter(backgroundColor, 1.375)
  property color overlayColor: Qt.rgba(backgroundColorDark.r, backgroundColorDark.g, backgroundColorDark.b, 0.6)
  property color snackbarColorLight: "#323232"
  property color snackbarColorDark: "#F0F0F0"
  property color snackbarTextColorLight: Qt.rgba(textColorDark.r, textColorDark.g, textColorDark.b,
    primaryTextColorRatioLight)
  property color snackbarTextColorDark: primaryTextColorLight
  function snackbarColor() { return theme === Style.Theme.Light ? snackbarColorLight : snackbarColorDark }

  function snackbarRippleColor() { return theme === Style.Theme.Light ? rippleColorLight : rippleColorDark }

  function snackbarTextColor() { return theme === Style.Theme.Light ? snackbarTextColorLight : snackbarTextColorDark }

  property color buttonColor: primaryColor
  property color buttonAccentColor: accentColor
  property color buttonDisabledColor: theme === Style.Theme.Light ? Qt.darker(paneColor, 1.12) : Qt.lighter(paneColor,
    1.1)
  property color buttonTextColor: primaryTextColorDark
  property color buttonOutlinedColor: "#1E000000"

  property color rippleColorLight: "#20FFFFFF"
  property color rippleColorDark: "#0C000000"
  property color rippleColorTheme: theme === Style.Theme.Light ? rippleColorDark : rippleColorLight
  property color rippleColorThemeReversed: theme === Style.Theme.Light ? rippleColorLight : rippleColorDark

  enum RippleBackground
  {
    Background,
    Primary,
    Accent,
    AccentLight
  } // RippleBackground

  function rippleColor(rippleBackground)
  {
    switch (rippleBackground)
    {
      case Style.RippleBackground.Background:
        return theme === Style.Theme.Light ? rippleColorDark : rippleColorLight
      case Style.RippleBackground.Primary:
        return shouldReverseRippleOnPrimary ? rippleColorThemeReversed : rippleColorTheme
      case Style.RippleBackground.Accent:
        return rippleColorLight
      case Style.RippleBackground.AccentLight:
        return Qt.rgba(Style.accentColor.r, Style.accentColor.g, Style.accentColor.b, 0.2)
      default:
        break
    }
    return rippleColorLight
  } // function rippleColor(rippleBackground)

  enum Position
  {
    TopLeft,
    TopStart,
    Top,
    TopEnd,
    TopRight,
    RightStart,
    Right,
    RightEnd,
    BottomRight,
    BottomEnd,
    Bottom,
    BottomStart,
    BottomLeft,
    LeftEnd,
    Left,
    LeftStart,
    Center
  } // Position

  enum TextType
  {
    Display3,
    Display2,
    Display1,
    Heading,
    Title,
    Subheading,
    ListText,
    ListSecText,
    Overline,
    Body2,
    Body1,
    Caption,
    Hint,
    Button,
    Menu,
    MenuHint
  } // TextType

  property bool usePixelSize: true

  property string fontFamily: "Roboto"

  property string display3FontFamily: fontFamily
  property string display2FontFamily: fontFamily
  property string display1FontFamily: fontFamily
  property string headingFontFamily: fontFamily
  property string titleFontFamily: fontFamily
  property string subHeadingFontFamily: fontFamily
  property string listTextFontFamily: fontFamily
  property string listSecTextFontFamily: fontFamily
  property string overlineFontFamily: fontFamily
  property string body2FontFamily: fontFamily
  property string body1FontFamily: fontFamily
  property string captionFontFamily: fontFamily
  property string hintFontFamily: fontFamily
  property string buttonFontFamily: fontFamily
  property string menuFontFamily: fontFamily
  property string menuHintFontFamily: fontFamily

  property string display3FontStyleName: "Regular"
  property string display2FontStyleName: "Regular"
  property string display1FontStyleName: "Regular"
  property string headingFontStyleName: "Regular"
  property string titleFontStyleName: "Medium"
  property string subHeadingFontStyleName: "Regular"
  property string listTextFontStyleName: "Regular"
  property string listSecTextFontStyleName: "Regular"
  property string overlineFontStyleName: "Medium"
  property string body2FontStyleName: "Medium"
  property string body1FontStyleName: "Regular"
  property string captionFontStyleName: "Regular"
  property string hintFontStyleName: "Regular"
  property string buttonFontStyleName: "Medium"
  property string menuFontStyleName: "Regular"
  property string menuHintFontStyleName: "Medium"

  property double display3FontPointSize: _root.dense ? 37.5 : 42
  property double display2FontPointSize: _root.dense ? 30 : 33.75
  property double display1FontPointSize: _root.dense ? 23.25 : 25.5
  property double headingFontPointSize: _root.dense ? 16.5 : 18
  property double titleFontPointSize: _root.dense ? 13.5 : 15
  property double subHeadingFontPointSize: _root.dense ? 10.5 : 12
  property double listTextFontPointSize: _root.dense ? 10.5 : 12
  property double listSecTextFontPointSize: _root.dense ? 9 : 10.5
  property double overlineFontPointSize: _root.dense ? 7.5 : 8.5
  property double body2FontPointSize: _root.dense ? 9 : 10.5
  property double body1FontPointSize: _root.dense ? 9 : 10.5
  property double captionFontPointSize: _root.dense ? 8 : 9
  property double hintFontPointSize: _root.dense ? 7.5 : 8.5
  property double buttonFontPointSize: _root.dense ? 9 : 11
  property double menuFontPointSize: _root.dense ? 10.5 : 12
  property double menuHintFontPointSize: _root.dense ? 9 : 10.5

  property double display3FontPixelSize: _root.dense ? 50 : 56
  property double display2FontPixelSize: _root.dense ? 42 : 45
  property double display1FontPixelSize: _root.dense ? 32 : 34
  property double headingFontPixelSize: _root.dense ? 22 : 24
  property double titleFontPixelSize: _root.dense ? 19 : 20
  property double subHeadingFontPixelSize: _root.dense ? 15 : 16
  property double listTextFontPixelSize: _root.dense ? 15 : 16
  property double listSecTextFontPixelSize: _root.dense ? 13 : 14
  property double overlineFontPixelSize: _root.dense ? 10 : 11
  property double body2FontPixelSize: _root.dense ? 13 : 14
  property double body1FontPixelSize: _root.dense ? 13 : 14
  property double captionFontPixelSize: _root.dense ? 11 : 12
  property double hintFontPixelSize: _root.dense ? 10 : 11
  property double buttonFontPixelSize: _root.dense ? 13 : 14
  property double menuFontPixelSize: _root.dense ? 13 : 14
  property double menuHintFontPixelSize: _root.dense ? 11 : 12

  function textTypeToFontFamily(type)
  {
    switch (type)
    {
      case Style.TextType.Display3:
        return display3FontFamily;
      case Style.TextType.Display2:
        return display2FontFamily;
      case Style.TextType.Display1:
        return display1FontFamily;
      case Style.TextType.Heading:
        return headingFontFamily;
      case Style.TextType.Title:
        return titleFontFamily;
      case Style.TextType.Subheading:
        return subHeadingFontFamily;
      case Style.TextType.ListText:
        return listTextFontFamily;
      case Style.TextType.ListSecText:
        return listSecTextFontFamily;
      case Style.TextType.Overline:
        return overlineFontFamily;
      case Style.TextType.Body2:
        return body2FontFamily;
      case Style.TextType.Body1:
        return body1FontFamily;
      case Style.TextType.Caption:
        return captionFontFamily;
      case Style.TextType.Hint:
        return hintFontFamily;
      case Style.TextType.Button:
        return buttonFontFamily;
      case Style.TextType.Menu:
        return menuFontFamily;
      case Style.TextType.MenuHint:
        return menuHintFontFamily;
      default:
        break;
    }
    console.log("Unknown Text Type : " + type)
    return body1FontFamily;
  } // function textTypeToFontFamily(type)

  function textTypeToStyleName(type)
  {
    switch (type)
    {
      case Style.TextType.Display3:
        return display3FontStyleName;
      case Style.TextType.Display2:
        return display2FontStyleName;
      case Style.TextType.Display1:
        return display1FontStyleName;
      case Style.TextType.Heading:
        return headingFontStyleName;
      case Style.TextType.Title:
        return titleFontStyleName;
      case Style.TextType.Subheading:
        return subHeadingFontStyleName;
      case Style.TextType.ListText:
        return listTextFontStyleName;
      case Style.TextType.ListSecText:
        return listSecTextFontStyleName;
      case Style.TextType.Overline:
        return overlineFontStyleName;
      case Style.TextType.Body2:
        return body2FontStyleName;
      case Style.TextType.Body1:
        return body1FontStyleName;
      case Style.TextType.Caption:
        return captionFontStyleName;
      case Style.TextType.Hint:
        return hintFontStyleName;
      case Style.TextType.Button:
        return buttonFontStyleName;
      case Style.TextType.Menu:
        return menuFontStyleName;
      case Style.TextType.MenuHint:
        return menuHintFontStyleName;
      default:
        break;
    }
    console.log("Unknown Text Type : " + type)
    return body1FontStyleName;
  } // function textTypeToStyleName(type)

  function textTypeToPointSize(type)
  {
    switch (type)
    {
      case Style.TextType.Display3:
        return display3FontPointSize;
      case Style.TextType.Display2:
        return display2FontPointSize;
      case Style.TextType.Display1:
        return display1FontPointSize;
      case Style.TextType.Heading:
        return headingFontPointSize;
      case Style.TextType.Title:
        return titleFontPointSize;
      case Style.TextType.Subheading:
        return subHeadingFontPointSize;
      case Style.TextType.ListText:
        return listTextFontPointSize;
      case Style.TextType.ListSecText:
        return listSecTextFontPointSize;
      case Style.TextType.Overline:
        return overlineFontPointSize;
      case Style.TextType.Body2:
        return body2FontPointSize;
      case Style.TextType.Body1:
        return body1FontPointSize;
      case Style.TextType.Caption:
        return captionFontPointSize;
      case Style.TextType.Hint:
        return hintFontPointSize;
      case Style.TextType.Button:
        return buttonFontPointSize;
      case Style.TextType.Menu:
        return menuFontPointSize;
      case Style.TextType.MenuHint:
        return menuHintFontPointSize;
      default:
        break;
    }
    console.log("Unknown Text Type : " + type)
    return body1FontPointSize;
  } // function textTypeToPointSize(type)

  function textTypeToPixelSize(type)
  {
    switch (type)
    {
      case Style.TextType.Display3:
        return display3FontPixelSize;
      case Style.TextType.Display2:
        return display2FontPixelSize;
      case Style.TextType.Display1:
        return display1FontPixelSize;
      case Style.TextType.Heading:
        return headingFontPixelSize;
      case Style.TextType.Title:
        return titleFontPixelSize;
      case Style.TextType.Subheading:
        return subHeadingFontPixelSize;
      case Style.TextType.ListText:
        return listTextFontPixelSize;
      case Style.TextType.ListSecText:
        return listSecTextFontPixelSize;
      case Style.TextType.Overline:
        return overlineFontPixelSize;
      case Style.TextType.Body2:
        return body2FontPixelSize;
      case Style.TextType.Body1:
        return body1FontPixelSize;
      case Style.TextType.Caption:
        return captionFontPixelSize;
      case Style.TextType.Hint:
        return hintFontPixelSize;
      case Style.TextType.Button:
        return buttonFontPixelSize;
      case Style.TextType.Menu:
        return menuFontPixelSize;
      case Style.TextType.MenuHint:
        return menuHintFontPixelSize;
      default:
        break;
    }
    console.log("Unknown Text Type : " + type)
    return body1FontPixelSize;
  } // function textTypeToPixelSize(type)

  function textTypeToColor(type)
  {
    switch (type)
    {
      case Style.TextType.Display3:
        return displayTextColor();
      case Style.TextType.Display2:
        return displayTextColor();
      case Style.TextType.Display1:
        return displayTextColor();
      case Style.TextType.Heading:
        return primaryTextColor();
      case Style.TextType.Title:
        return primaryTextColor();
      case Style.TextType.Subheading:
        return primaryTextColor();
      case Style.TextType.ListText:
        return primaryTextColor();
      case Style.TextType.ListSecText:
        return secondaryTextColor();
      case Style.TextType.Overline:
        return secondaryTextColor();
      case Style.TextType.Body2:
        return primaryTextColor();
      case Style.TextType.Body1:
        return primaryTextColor();
      case Style.TextType.Caption:
        return secondaryTextColor();
      case Style.TextType.Hint:
        return hintTextColor();
      case Style.TextType.Button:
        return primaryTextColor();
      case Style.TextType.Menu:
        return primaryTextColor();
      case Style.TextType.MenuHint:
        return secondaryTextColor();
      default:
        break;
    }
    console.log("Unknown Text Type : " + type)
    return primaryTextColor();
  } // function textTypeToColor(type)

  function textTypeToColorReversed(type)
  {
    switch (type)
    {
      case Style.TextType.Display3:
        return displayTextColorReversed();
      case Style.TextType.Display2:
        return displayTextColorReversed();
      case Style.TextType.Display1:
        return displayTextColorReversed();
      case Style.TextType.Heading:
        return primaryTextColorReversed();
      case Style.TextType.Title:
        return primaryTextColorReversed();
      case Style.TextType.Subheading:
        return primaryTextColorReversed();
      case Style.TextType.ListText:
        return primaryTextColorReversed();
      case Style.TextType.ListSecText:
        return secondaryTextColorReversed();
      case Style.TextType.Overline:
        return secondaryTextColorReversed();
      case Style.TextType.Body2:
        return primaryTextColorReversed();
      case Style.TextType.Body1:
        return primaryTextColorReversed();
      case Style.TextType.Caption:
        return secondaryTextColorReversed();
      case Style.TextType.Hint:
        return hintTextColorReversed();
      case Style.TextType.Button:
        return primaryTextColorReversed();
      case Style.TextType.Menu:
        return primaryTextColorReversed();
      case Style.TextType.MenuHint:
        return secondaryTextColorReversed();
      default:
        break;
    }
    console.log("Unknown Text Type : " + type)
    return primaryTextColorReversed();
  } // function textTypeToColorReversed(type)

  function fontCapitalization(type)
  {
    switch (type)
    {
      case Style.TextType.Overline:
      case Style.TextType.Button:
        return Font.AllUppercase;
      default:
        break;
    }
    return Font.MixedCase;
  } // function fontCapitalization(type)

  function textTypeToLetterSpacing(type)
  {
    switch (type)
    {
      case Style.TextType.Overline:
        return 2;
      case Style.TextType.ListSecText:
        return 0.4;
      default:
        break;
    }
    return 0;
  } // function textTypeToLetterSpacing(type)

  property
  var rawButton: QtObject
  {
    property double minWidth: _root.dense ? 52 : 64
    property double minHeight: _root.dense ? 24 : 36
    property double padding: _root.dense ? 7 : 16
    property double iconPadding: _root.dense ? 6 : 12
    property double spacing: _root.dense ? 4 : 8
    property double iconWidth: _root.dense ? 14 : 18
    property double cornerRadius: _root.dense ? 2 : 4

    property double defaultElevation: 2
    property double flatElevation: 0
    property double defaultPressedElevation: _root.dense ? 6 : 8
    property double flatPressedElevation: _root.dense ? 1 : 2

    property double topInset: _root.dense ? 4 : 6
    property double bottomInset: _root.dense ? 4 : 6
    property double leftInset: _root.dense ? 2 : 4
    property double rightInset: _root.dense ? 2 : 4

    property double outlinedWidth: 1
    property double outlinedFocusWidth: _root.dense ? 1 : 2
  } // QtObject

  enum FabType
  {
    Default,
    Mini,
    Extended
  } // FabType

  property
  var fab: QtObject
  {
    property double minWidth: _root.dense ? 44 : 56
    property double minWidthMini: _root.dense ? 32 : 40
    property double minWidthExtended: _root.dense ? 52 : 64
    property double minHeightExtended: minWidth //_root.dense ? 34 : 48

    property double flatInset: _root.dense ? 2 : 4
    property double flatInsetNoClip: _root.dense ? 5 : 10

    property double padding: _root.dense ? 8 : 16
    property double paddingMini: _root.dense ? 4 : 8
    property double iconPadding: _root.dense ? 8 : 12
    property double textPadding: _root.dense ? 12 : 20

    property double spacing: _root.dense ? 8 : 12
    property double iconWidth: _root.dense ? 18 : 24

    /*property double fontPointSize:              _root.buttonFontPointSize
      property int fontCapitalisation:            Font.AllUppercase
      property string fontFamily:                 _root.fontFamily
      property string fontStyleName:              "Medium"*/

    property double elevation: _root.dense ? 4 : 6
    property double pressedElevation: _root.dense ? 10 : 12

    property double anchorsOffset: _root.dense ? 10 : 16
  } // QtObject

  property
  var toolbar: QtObject
  {
    property double implicitHeight: _root.dense ? 38 : 48
    property double elevation: _root.dense ? 3 : 4
  } // QtObject

  property
  var toolButton: QtObject
  {
    property double minWidth: _root.dense ? 28 : 36
    property double minHeight: _root.dense ? 28 : 36

    property double appBarButtonWidth: _root.dense ? 24 : 30
    property double appBarButtonHeight: _root.dense ? 24 : 30

    property double padding: _root.dense ? 7 : 9

    property double spacing: _root.dense ? 8 : 12
    property double iconWidth: _root.dense ? 18 : 24

    property double topInset: _root.dense ? 2 : 6
    property double bottomInset: _root.dense ? 2 : 6
    property double leftInset: _root.dense ? 1 : 2
    property double rightInset: _root.dense ? 1 : 2

    property double elevation: _root.dense ? 0 : 0
    property double pressedElevation: _root.dense ? 0 : 0

    property double separatorLargePadding: _root.dense ? 3 : 6
    property double separatorSmallPadding: _root.dense ? 2 : 5
    property double separatorImplicitWidth: _root.dense ? 24 : 38
  } // QtObject

  property
  var tabBar: QtObject
  {
    property double elevation: 10
    property double highlightHeight: _root.dense ? 2 : 2
    property double minHeight: _root.dense ? 38 : 48
    property double minLeftWidth: _root.dense ? 40 : 52
    property double minTabWidth: _root.dense ? 96 : 127
    property double maxTabWidth: _root.dense ? 200 : 360
  } // QtObject

  property
  var tabButton: QtObject
  {
    property double minWidth: _root.dense ? 70 : 90
    property double minHeight: _root.dense ? 30 : 48
    property double minHeightWithIcon: _root.dense ? 50 : 72
    property double minHeightWithSmallIcon: _root.dense ? 42 : 48
    property double padding: _root.dense ? 8 : 16

    property double spacing: _root.dense ? 3 : 6
    property double smallSpacing: _root.dense ? 2 : 3
    property double spacingVertical: _root.dense ? 12 : 15
    property double smallSpacingVertical: _root.dense ? 11 : 14

    property double topPadding: _root.dense ? 6 : 12
    property double smallTopPadding: _root.dense ? 3 : 6
    property double iconPadding: _root.dense ? 6 : 12
    property double iconWidth: _root.dense ? 18 : 24

    property double topInset: _root.dense ? 0 : 0
    property double bottomInset: _root.dense ? 0 : 0
    property double leftInset: _root.dense ? 0 : 0
    property double rightInset: _root.dense ? 0 : 0
  } // QtObject

  enum DelegateType
  {
    Default = 0,
      Overline = 1,
      Icon = 2,
      Round = 3,
      RoundIcon = 3,
      Square = 4,
      Large = 5
  } // DelegateType

  property
  var delegate: QtObject
  {
    property double implicitWidth: _root.dense ? 160 : 200

    function implicitHeight1Line(type)
    {
      switch (type)
      {
        case Style.DelegateType.Overline:
          return _root.dense ? 52 : 64
        case Style.DelegateType.Icon:
        case Style.DelegateType.Round:
          return _root.dense ? 44 : 56
        case Style.DelegateType.Square:
        case Style.DelegateType.Large:
          return _root.dense ? 58 : 72
        default:
          break
      }
      return _root.dense ? 38 : 48
    } // function implicitHeight1Line(type)

    function implicitHeight2Line(type)
    {
      switch (type)
      {
        case Style.DelegateType.Overline:
          return _root.dense ? 70 : 88
        case Style.DelegateType.Icon:
        case Style.DelegateType.Round:
        case Style.DelegateType.Square:
        case Style.DelegateType.Large:
          return _root.dense ? 62 : 72
        default:
          break
      }
      return _root.dense ? 52 : 64
    } // function implicitHeight2Line(type)

    function implicitHeight3Line(type)
    {
      return _root.dense ? 70 : 88
    } // function implicitHeight3Line(type)

    function implicitHeight(type, lines)
    {
      switch (lines)
      {
        case 2:
          return implicitHeight2Line(type)
        case 3:
          return implicitHeight3Line(type)
        default:
          return implicitHeight1Line(type)
      }
    } // function implicitHeight(type, lines)

    function spacing(type, lines)
    {
      if(lines === 3)
      {
        switch (type)
        {
          case Style.DelegateType.Icon:
            return _root.dense ? 26 : 32
          case Style.DelegateType.Round:
          case Style.DelegateType.Square:
            return _root.dense ? 12 : 16
          case Style.DelegateType.Large:
            return _root.dense ? 16 : 20
          default:
            break
        }
        return 0;
      }
      else
      {
        switch (type)
        {
          case Style.DelegateType.Icon:
            return _root.dense ? 26 : 32
          case Style.DelegateType.Round:
          case Style.DelegateType.Square:
          case Style.DelegateType.Large:
            return _root.dense ? 12 : 16
          default:
            break
        }
        return 0;
      }
    } // function spacing(type, lines)

    function topPadding1Line(type, lines)
    {
      switch (type)
      {
        case Style.DelegateType.Icon:
          return _root.dense ? 12 : 16
        case Style.DelegateType.Round:
          return _root.dense ? 6 : 8
        case Style.DelegateType.Square:
        case Style.DelegateType.Large:
          return _root.dense ? 7 : 8
        default:
          break
      }
      return 0
    } // function topPadding1Line(type, lines)

    function topPadding2Line(type, lines)
    {
      switch (type)
      {
        case Style.DelegateType.Icon:
          return _root.dense ? 20 : 24
        case Style.DelegateType.Round:
          return _root.dense ? 12 : 16
        case Style.DelegateType.Square:
        case Style.DelegateType.Large:
          return _root.dense ? 9 : 8
        default:
          break
      }
      return 0
    } // function topPadding2Line(type, lines)

    function topPadding3Line(type, lines)
    {
      switch (type)
      {
        case Style.DelegateType.Icon:
        case Style.DelegateType.Round:
        case Style.DelegateType.Square:
        case Style.DelegateType.Large:
          return _root.dense ? 12 : 16
        default:
          break
      }
      return 0
    } // unction topPadding3Line(type, lines)

    function topPadding(type, lines)
    {
      switch (lines)
      {
        case 2:
          return topPadding2Line(type)
        case 3:
          return topPadding3Line(type)
        default:
          return topPadding1Line(type)
      }
    } // function topPadding(type, lines)

    function leftPadding(type, lines)
    {
      if(type === Style.DelegateType.Large)
        return 0
      return _root.dense ? 12 : 16
    } // function leftPadding(type, lines)

    function rightPadding(type, lines)
    {
      return _root.dense ? 12 : 16
    } // function rightPadding(type, lines)

    function baselineOffsetText(type, lines)
    {
      if(type === Style.DelegateType.Overline)
        return _root.dense ? 38 : 48
      else if(lines === 2)
      {
        switch (type)
        {
          case Style.DelegateType.Icon:
          case Style.DelegateType.Round:
          case Style.DelegateType.Square:
          case Style.DelegateType.Large:
            return _root.dense ? 26 : 32
          default:
            break
        }
        return _root.dense ? 22 : 28
      }
      else if(lines >= 3)
      {
        return _root.dense ? 22 : 28
      }
      return 0
    } // function baselineOffsetText(type, lines)

    function baselineOffsetSecText(type, lines)
    {
      if(type === Style.DelegateType.Overline)
        return _root.dense ? 53 : 70
      else if(lines === 2)
      {
        switch (type)
        {
          case Style.DelegateType.Icon:
          case Style.DelegateType.Round:
          case Style.DelegateType.Square:
          case Style.DelegateType.Large:
            return _root.dense ? 42 : 52
          default:
            break
        }
        return _root.dense ? 38 : 48
      }
      else if(lines >= 3)
      {
        return _root.dense ? 38 : 48
      }
      return 0
    } // function baselineOffsetSecText(type, lines)

    function baselineOffsetOverline(lines)
    {
      return _root.dense ? 20 : 28
    } // function baselineOffsetOverline(lines)

    function roundWidth(large) { return squareWidth(large) } // function roundWidth(large)
    function squareWidth(large) { return large ? (_root.dense ? 44 : 56) : (_root.dense ? 32 :
      40) } // function squareWidth(large)
    function largeWidth() { return _root.dense ? 80 : 100 } // function largeWidth()
    function largeHeight(lines) { return (_root.dense ? 44 : 56) } // function largeHeight(lines)

    property double iconWidth: _root.dense ? 20 : 24
    property double indicatorPadding: _root.dense ? 12 : 16

  } // QtObject

  property
  var debug: QtObject
  {
    property bool drawDebugButton: false
    property bool drawDebugIconLabel: false
    property bool drawDebugDelegate: false
  } // QtObject

  property
  var switchIndicator: QtObject
  {
    property color switchCheckedTrackColor: Qt.rgba(Style.accentColor.r, Style.accentColor.g, Style.accentColor.b,
      0.5)
    property color switchUncheckedTrackColor: Style.dividersColor()
    property color switchDisabledTrackColor: Style.disabledDividersColor()

    property color switchCheckedHandleColor: Style.accentColor
    property color switchUncheckedHandleColor: Style.theme === Style.Theme.Light ? Style.primaryTextColorDark : Style
      .secondaryTextColorDark
    property color switchDisabledHandleColor: Qt.darker(switchUncheckedHandleColor, (Style.theme === Style.Theme
      .Light) ? 1.25 : 1.6)

    property double implicitWidth: _root.dense ? 30 : 38
    property double implicitHeight: _root.dense ? 26 : 32
    property double trackHeight: _root.dense ? 12 : 14
    property double handleRadius: _root.dense ? 16 : 20
  } // QtObject

  property
  var radioIndicator: QtObject
  {
    property double implicitWidth: _root.dense ? 16 : 20
    property double implicitHeight: _root.dense ? 16 : 20
  } // QtObject

  property
  var checkIndicator: QtObject
  {
    property double implicitWidth: _root.dense ? 16 : 18
    property double implicitHeight: _root.dense ? 16 : 18
    property double iconWidth: _root.dense ? 16 : 19
    property double radius: 2
    property double partiallyCheckedWidth: _root.dense ? 10 : 12
    property double partiallyCheckedHeight: _root.dense ? 2 : 3
  } // QtObject

  property
  var switchButton: QtObject
  {
    property double horizontalPadding: _root.dense ? 6 : 8
    property double verticalPadding: _root.dense ? 4 : 8
    property double spacing: _root.dense ? 8 : 12
    property double rippleWidth: _root.dense ? 24 : 28
  } // QtObject

  property
  var checkButton: QtObject
  {
    property double horizontalPadding: _root.dense ? 6 : 8
    property double verticalPadding: _root.dense ? 6 : 14
    property double spacing: _root.dense ? 8 : 12
    property double rippleWidth: _root.dense ? 24 : 28
  } // QtObject

  property
  var radioButton: QtObject
  {
    property double horizontalPadding: _root.dense ? 6 : 8
    property double verticalPadding: _root.dense ? 6 : 14
    property double spacing: _root.dense ? 8 : 12
    property double rippleWidth: _root.dense ? 18 : 28
  } // QtObject

  property
  var menu: QtObject
  {
    property double elevation: _root.dense ? 6 : 8
    property double verticalPadding: _root.dense ? 2 : 8
    property double implicitHeight: _root.dense ? 28 : 38
    property double implicitWidth: _root.dense ? 160 : 200
    property double radius: _root.dense ? 0 : 0
    property double separatorWLargePadding: _root.dense ? 28 : 40
    property double separatorWSmallPadding: _root.dense ? 4 : 8
    property double separatorHSmallPadding: _root.dense ? 2 : 4
    property double separatorImplicitWidth: _root.dense ? 150 : 200
  } // QtObject

  property
  var menuBarItem: QtObject
  {
    property double minWidth: _root.dense ? 54 : 64
    property double minHeight: _root.dense ? 24 : 32
    property double padding: _root.dense ? 4 : 6
    property double iconPadding: _root.dense ? 2 : 4
    property double spacing: _root.dense ? 2 : 4
    property double iconWidth: _root.dense ? 14 : 18
    property double cornerRadius: _root.dense ? 2 : 4

    property double topInset: _root.dense ? 2 : 4
    property double bottomInset: _root.dense ? 2 : 4
    property double leftInset: _root.dense ? 0 : 0
    property double rightInset: _root.dense ? 0 : 0
  } // QtObject

  property
  var menuItem: QtObject
  {
    property double minWidth: _root.dense ? 160 : 200
    property double minHeight: _root.dense ? 24 : 32
    property double padding: _root.dense ? 8 : 12
    property double iconPadding: _root.dense ? 8 : 12
    property double spacing: _root.dense ? 10 : 16
    property double iconWidth: _root.dense ? 14 : 18
    property double cornerRadius: _root.dense ? 0 : 0
    property double shortcutImplicitWidth: _root.dense ? 74 : 96

    property double topInset: _root.dense ? 0 : 0
    property double bottomInset: _root.dense ? 0 : 0
    property double leftInset: _root.dense ? 1 : 2
    property double rightInset: _root.dense ? 1 : 2
  } // QtObject

  property
  var scroll: QtObject
  {
    property double implicitWidth: _root.dense ? 7 : 12
    property double implicitWidthBackground: _root.dense ? 7 : 12
    property double implicitWidthInactive: _root.dense ? 2 : 4
    property double radius: _root.dense ? 2 : 4
    property double padding: _root.dense ? 4 : 4
  } // QtObject

  property
  var card: QtObject
  {
    property double horizontalPadding: _root.dense ? 12 : 16
    property double verticalPadding: _root.dense ? 6 : 8
    property double radius: _root.dense ? 3 : 4
    property double defaultElevation: _root.dense ? 1 : 1
    property double activeElevation: _root.dense ? 6 : 8
    property double spacing: _root.dense ? 4 : 6

    property double roundImageSpacing: _root.dense ? 12 : 16
    property double roundImageSize: _root.dense ? 32 : 40

    property double mediaImplicitWidth: _root.dense ? 276 : 344
    property double mediaImplicitHeight: _root.dense ? 156 : 194
  } // QtObject

  property
  var banner: QtObject
  {
    property double minimumWidth: _root.dense ? 288 : 360
    property double smallTextPadding: _root.dense ? 28 : 36
    property double smallTextPaddingDesktop: _root.dense ? 72 : 90

    property double mobileMaxWidth: _root.dense ? 520 : 650

    property double implicitHeight1Line: _root.dense ? 44 : 54
    property double implicitHeight2Line: _root.dense ? 90 : 112
    property double implicitHeightThumb: _root.dense ? 96 : 120
    property double implicitHeight1LineDesk: _root.dense ? 42 : 52
    property double implicitHeight2LineDesk: _root.dense ? 58 : 72
    property double implicitHeight3LineDesk: _root.dense ? 72 : 90
  } // QtObject

  property
  var roundIcon: QtObject
  {
    property double size: _root.dense ? 32 : 40
    property double iconWidth: _root.dense ? 18 : 24
  }

  property
  var snackbar: QtObject
  {
    property double implicitWidth: _root.dense ? 276 : 344
    property double implicitHeight: _root.dense ? 38 : 48
    property double implicitHeight2: _root.dense ? 54 : 68
    property double radius: _root.dense ? 3 : 4
    property double elevation: 6
    property double shortDisplayTime: 2000
    property double longDisplayTime: 5000
  } // QtObject

  property
  var textField: QtObject
  {
    property double cursorWidth: _root.dense ? 2 : 2
    property double implicitWidth: _root.dense ? 96 : 120
    property double horizontalPadding: 0 //_root.dense ? 12 : 16
    property double leadingSpacing: _root.dense ? 12 : 16
    property double textSpacing: _root.dense ? 2 : 4

    property double topPadding: _root.dense ? 6 : 8
    property double topPaddingTitle: _root.dense ? 18 : 22
    property double topPaddingTitleOffset: _root.dense ? 2 : 4
    property double bottomPadding: _root.dense ? 8 : 10
    property double bottomPaddingHint: _root.dense ? 24 : 28
    property double bottomPaddingHintOffset: _root.dense ? 2 : 4

    property double iconSize: _root.dense ? 20 : 24
    property double iconWidth: _root.dense ? 32 : 40

    // background
    property double backgroundBorderHeight: _root.dense ? 2 : 2
    property double backgroundVerticalOffset: _root.dense ? 6 : 8
  } // QtObject

  property
  var dialog: QtObject
  {
    property double spacing: 0
    property double padding: _root.dense ? 2 : 4
    property double buttonRectImplicitHeight: _root.dense ? 42 : 52
    property double radius: _root.dense ? 2 : 4
    property double horizontalPadding: _root.dense ? 18 : 24
    property double topPadding: _root.dense ? 16 : 20
    property double elevation: _root.dense ? 18 : 24
    property double implicitWidth: _root.dense ? 224 : 280
    property double maxHeight: _root.dense ? 500 : 500
    property double indicatorSpacing: _root.dense ? 18 : 24
  } // QtObject

  property
  var toolTip: QtObject
  {
    property double implicitHeight: _root.dense ? 24 : 32
    property double radius: _root.dense ? 2 : 4
    property double opacity: 0.9
    property double padding: _root.dense ? 8 : 16
  }

  property
  var slider: QtObject
  {
    property double implicitWidth: _root.dense ? 180 : 200
    property double implicitHeight: _root.dense ? 34 : 48
    property double padding: _root.dense ? 6 : 8
  }
} // QtObject
