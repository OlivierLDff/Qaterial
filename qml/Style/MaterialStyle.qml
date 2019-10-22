/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */
 pragma Singleton

import QtQuick 2.12
import QtQuick.Controls 2.12

import QQuickMaterialHelper.Style 1.12
import QQuickMaterialHelper.Fonts 1.12

QtObject
{
    id: root

    enum Theme
    {
        Light,
        Dark
    }

    // !!!!! FONT LOADER MUST BE SET FIRST !!!!! /
    //RobotoFontLoader {}

    property int theme: MaterialStyle.Theme.Dark
    property bool dense: false

    property bool foregroundReversedOnPrimaryLight: true
    property bool foregroundReversedOnPrimaryDark: false

    property bool rippleReversedOnPrimaryLight: true
    property bool rippleReversedOnPrimaryDark: false

    property bool foregroundReversedOnAccentLight: true
    property bool foregroundReversedOnAccentDark: false

    property bool preferAccentOnPrimaryLight: false
    property bool preferAccentOnPrimaryDark: true

    property bool shouldReverseForegroundOnPrimary: theme === MaterialStyle.Theme.Light ? foregroundReversedOnPrimaryLight : foregroundReversedOnPrimaryDark
    property bool shouldReverseRippleOnPrimary:     theme === MaterialStyle.Theme.Light ? rippleReversedOnPrimaryLight : rippleReversedOnPrimaryDark
    property bool shouldReverseForegroundOnAccent:  theme === MaterialStyle.Theme.Light ? foregroundReversedOnAccentLight : foregroundReversedOnAccentDark
    property bool preferAccentOnPrimary:            theme === MaterialStyle.Theme.Light ? preferAccentOnPrimaryLight : preferAccentOnPrimaryDark

    property color primaryColorLight:               "#f44336"
    property color primaryColorDark:                "#202225"//"#212121"
    property color accentColorLight:                "#FFC107"
    property color accentColorDark:                 "#FFB835"
    property color backgroundColorLight:            "#FFFFFF"
    property color backgroundColorDark:             "#2F3136"//"#303030"
    property color foregroundColorLight:            "#000000"
    property color foregroundColorDark:             "#FFFFFF"

    property color blueGrey:                        "#607D8B"
    property color grey:                            "#9E9E9E"
    property color brown:                           "#795548"
    property color deepOrange:                      "#FF5722"
    property color orange:                          "#FF9800"
    property color amber:                           "#FFC107"
    property color yellow:                          "#FFEB3B"
    property color lime:                            "#8BC34A"
    property color green:                           "#4CAF50"
    property color teal:                            "#009688"
    property color cyan:                            "#00BCD4"
    property color lightBlue:                       "#03A9F4"
    property color blue:                            "#2196F3"
    property color indigo:                          "#3F51B5"
    property color deepPurple:                      "#673AB7"
    property color purple:                          "#9C27B0"
    property color pink:                            "#E91E63"
    property color red:                             "#f44336"


    property color primaryColor:                    theme === MaterialStyle.Theme.Light ? primaryColorLight : primaryColorDark
    property color accentColor:                     theme === MaterialStyle.Theme.Light ? accentColorLight : accentColorDark
    property color backgroundColor:                 theme === MaterialStyle.Theme.Light ? backgroundColorLight : backgroundColorDark
    property color foregroundColor:                 theme === MaterialStyle.Theme.Light ? foregroundColorLight : foregroundColorDark

    property color textColorLight:                  foregroundColorLight
    property color textColorDark:                   foregroundColorDark
    property color textColor:                       theme === MaterialStyle.Theme.Light ? textColorLight : textColorDark
    property color errorColor:                      "#f44336"

    property double primaryTextColorRatioLight:         0.87
    property double displayTextColorRatioLight:         0.65
    property double secondaryTextColorRatioLight:       0.54
    property double disabledTextColorRatioLight:        0.38
    property double hintTextColorRatioLight:            0.38
    property double iconColorRatioLight:                0.38
    property double helperTextColorRatioLight:          0.38
    property double dividersColorRatioLight:            0.23
    property double disabledDividersColorRatioLight:    0.12
    property double errorTextColorRatioLight:           1.00

    property double primaryTextColorRatioDark:          1.00
    property double displayTextColorRatioDark:          0.70
    property double secondaryTextColorRatioDark:        0.70
    property double disabledTextColorRatioDark:         0.50
    property double hintTextColorRatioDark:             0.50
    property double iconColorRatioDark:                 0.50
    property double helperTextColorRatioDark:           0.50
    property double dividersColorRatioDark:             0.20
    property double disabledDividersColorRatioDark:     0.12
    property double errorTextColorRatioDark:            1.00

    property color primaryTextColorLight:           Qt.rgba(textColorLight.r, textColorLight.g, textColorLight.b, primaryTextColorRatioLight)
    property color displayTextColorLight:           Qt.rgba(textColorLight.r, textColorLight.g, textColorLight.b, displayTextColorRatioLight)
    property color secondaryTextColorLight:         Qt.rgba(textColorLight.r, textColorLight.g, textColorLight.b, secondaryTextColorRatioLight)
    property color disabledTextColorLight:          Qt.rgba(textColorLight.r, textColorLight.g, textColorLight.b, disabledTextColorRatioLight)
    property color hintTextColorLight:              Qt.rgba(textColorLight.r, textColorLight.g, textColorLight.b, hintTextColorRatioLight)
    property color iconColorLight:                  Qt.rgba(textColorLight.r, textColorLight.g, textColorLight.b, iconColorRatioLight)
    property color helperTextColorLight:            Qt.rgba(textColorLight.r, textColorLight.g, textColorLight.b, helperTextColorRatioLight)
    property color dividersColorLight:              Qt.rgba(textColorLight.r, textColorLight.g, textColorLight.b, dividersColorRatioLight)
    property color disabledDividersColorLight:      Qt.rgba(textColorLight.r, textColorLight.g, textColorLight.b, disabledDividersColorRatioLight)
    property color errorTextColorLight:             Qt.rgba(errorColor.r, errorColor.g, errorColor.b, errorTextColorRatioLight)

    property color primaryTextColorDark:            Qt.rgba(textColorDark.r, textColorDark.g, textColorDark.b, primaryTextColorRatioDark)
    property color displayTextColorDark:            Qt.rgba(textColorDark.r, textColorDark.g, textColorDark.b, displayTextColorRatioDark)
    property color secondaryTextColorDark:          Qt.rgba(textColorDark.r, textColorDark.g, textColorDark.b, secondaryTextColorRatioDark)
    property color disabledTextColorDark:           Qt.rgba(textColorDark.r, textColorDark.g, textColorDark.b, disabledTextColorRatioDark)
    property color hintTextColorDark:               Qt.rgba(textColorDark.r, textColorDark.g, textColorDark.b, hintTextColorRatioDark)
    property color iconColorDark:                   Qt.rgba(textColorDark.r, textColorDark.g, textColorDark.b, iconColorRatioDark)
    property color helperTextColorDark:             Qt.rgba(textColorDark.r, textColorDark.g, textColorDark.b, helperTextColorRatioDark)
    property color dividersColorDark:               Qt.rgba(textColorDark.r, textColorDark.g, textColorDark.b, dividersColorRatioDark)
    property color disabledDividersColorDark:       Qt.rgba(textColorDark.r, textColorDark.g, textColorDark.b, disabledDividersColorRatioDark)
    property color errorTextColorDark:              Qt.rgba(errorColor.r, errorColor.g, errorColor.b, errorTextColorRatioDark)

    function primaryTextColor()                     { return theme === MaterialStyle.Theme.Light ? primaryTextColorLight       : primaryTextColorDark      }
    function displayTextColor()                     { return theme === MaterialStyle.Theme.Light ? displayTextColorLight       : displayTextColorDark      }
    function secondaryTextColor()                   { return theme === MaterialStyle.Theme.Light ? secondaryTextColorLight     : secondaryTextColorDark    }
    function disabledTextColor()                    { return theme === MaterialStyle.Theme.Light ? disabledTextColorLight      : disabledTextColorDark     }
    function hintTextColor()                        { return theme === MaterialStyle.Theme.Light ? hintTextColorLight          : hintTextColorDark         }
    function iconColor()                            { return theme === MaterialStyle.Theme.Light ? iconColorLight              : iconColorDark             }
    function helperTextColor()                      { return theme === MaterialStyle.Theme.Light ? helperTextColorLight        : helperTextColorDark       }
    function dividersColor()                        { return theme === MaterialStyle.Theme.Light ? dividersColorLight          : dividersColorDark         }
    function disabledDividersColor()                { return theme === MaterialStyle.Theme.Light ? disabledDividersColorLight  : disabledDividersColorDark }
    function errorTextColor()                       { return theme === MaterialStyle.Theme.Light ? errorTextColorLight         : errorTextColorDark        }

    function primaryTextColorReversed()             { return theme != MaterialStyle.Theme.Light ? primaryTextColorLight        : primaryTextColorDark      }
    function displayTextColorReversed()             { return theme != MaterialStyle.Theme.Light ? displayTextColorLight        : displayTextColorDark      }
    function secondaryTextColorReversed()           { return theme != MaterialStyle.Theme.Light ? secondaryTextColorLight      : secondaryTextColorDark    }
    function disabledTextColorReversed()            { return theme != MaterialStyle.Theme.Light ? disabledTextColorLight       : disabledTextColorDark     }
    function hintTextColorReversed()                { return theme != MaterialStyle.Theme.Light ? hintTextColorLight           : hintTextColorDark         }
    function iconColorReversed()                    { return theme != MaterialStyle.Theme.Light ? iconColorLight               : iconColorDark             }
    function helperTextColorReversed()              { return theme != MaterialStyle.Theme.Light ? helperTextColorLight         : helperTextColorDark       }
    function dividersColorReversed()                { return theme != MaterialStyle.Theme.Light ? dividersColorLight           : dividersColorDark         }
    function disabledDividersColorReversed()        { return theme != MaterialStyle.Theme.Light ? disabledDividersColorLight   : disabledDividersColorDark }
    function errorTextColorReversed()               { return theme != MaterialStyle.Theme.Light ? errorTextColorLight          : errorTextColorDark        }

    property color appBarColor:                     primaryColor
    property color dialogColor:                     Qt.lighter(backgroundColor, 1.375)
    property color cardColor:                       theme === MaterialStyle.Theme.Light ? backgroundColor : Qt.lighter(backgroundColor, 1.375)
    property color cardBackgroundColor:             theme === MaterialStyle.Theme.Light ? Qt.darker(backgroundColor, 1.25) : backgroundColor
    property color paneColor:                       Qt.lighter(backgroundColor, 1.375)
    property color overlayColor:                    Qt.rgba(backgroundColorDark.r, backgroundColorDark.g, backgroundColorDark.b, 0.6)
    property color snackbarColorLight:              "#323232"
    property color snackbarColorDark:               "#F0F0F0"
    property color snackbarTextColorLight:          Qt.rgba(textColorDark.r, textColorDark.g, textColorDark.b, primaryTextColorRatioLight)
    property color snackbarTextColorDark:           primaryTextColorLight
    function snackbarColor()                        { return theme === MaterialStyle.Theme.Light ? snackbarColorLight          : snackbarColorDark     }
    function snackbarRippleColor()                  { return theme === MaterialStyle.Theme.Light ? rippleColorLight            : rippleColorDark       }
    function snackbarTextColor()                    { return theme === MaterialStyle.Theme.Light ? snackbarTextColorLight      : snackbarTextColorDark }

    property color buttonColor:                     primaryColor
    property color buttonAccentColor:               accentColor
    property color buttonDisabledColor:             theme === MaterialStyle.Theme.Light ? Qt.darker(paneColor, 1.12) : Qt.lighter(paneColor, 1.1)
    property color buttonTextColor:                 primaryTextColorDark
    property color buttonOutlinedColor:             "#1E000000"

    property color rippleColorLight:                "#20FFFFFF"
    property color rippleColorDark:                 "#0C000000"
    property color rippleColorTheme:                theme === MaterialStyle.Theme.Light ? rippleColorDark : rippleColorLight
    property color rippleColorThemeReversed:        theme === MaterialStyle.Theme.Light ? rippleColorLight : rippleColorDark

    enum RippleBackground
    {
        Background,
        Primary,
        Accent,
        AccentLight
    }

    function rippleColor(rippleBackground)
    {
        switch(rippleBackground)
        {
            case MaterialStyle.RippleBackground.Background:
                return theme === MaterialStyle.Theme.Light ? rippleColorDark : rippleColorLight
            case MaterialStyle.RippleBackground.Primary:
                return shouldReverseRippleOnPrimary ? rippleColorThemeReversed : rippleColorTheme
            case MaterialStyle.RippleBackground.Accent:
                return rippleColorLight
            case MaterialStyle.RippleBackground.AccentLight:
                return Qt.rgba(MaterialStyle.accentColor.r, MaterialStyle.accentColor.g, MaterialStyle.accentColor.b, 0.2)
            default: break
        }
        return rippleColorLight
    }

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
    }

    property bool usePixelSize: true

    property string fontFamily: "Roboto"

    property string display3FontFamily:         fontFamily
    property string display2FontFamily:         fontFamily
    property string display1FontFamily:         fontFamily
    property string headingFontFamily:          fontFamily
    property string titleFontFamily:            fontFamily
    property string subHeadingFontFamily:       fontFamily
    property string listTextFontFamily:         fontFamily
    property string listSecTextFontFamily:      fontFamily
    property string overlineFontFamily:         fontFamily
    property string body2FontFamily:            fontFamily
    property string body1FontFamily:            fontFamily
    property string captionFontFamily:          fontFamily
    property string hintFontFamily:             fontFamily
    property string buttonFontFamily:           fontFamily
    property string menuFontFamily:             fontFamily
    property string menuHintFontFamily:         fontFamily

    property string display3FontStyleName:      "Regular"
    property string display2FontStyleName:      "Regular"
    property string display1FontStyleName:      "Regular"
    property string headingFontStyleName:       "Regular"
    property string titleFontStyleName:         "Medium"
    property string subHeadingFontStyleName:    "Regular"
    property string listTextFontStyleName:      "Regular"
    property string listSecTextFontStyleName:   "Regular"
    property string overlineFontStyleName:      "Medium"
    property string body2FontStyleName:         "Medium"
    property string body1FontStyleName:         "Regular"
    property string captionFontStyleName:       "Regular"
    property string hintFontStyleName:          "Regular"
    property string buttonFontStyleName:        "Medium"
    property string menuFontStyleName:          "Regular"
    property string menuHintFontStyleName:      "Medium"

    property double display3FontPointSize:      root.dense ? 37.5 : 42
    property double display2FontPointSize:      root.dense ? 30 : 33.75
    property double display1FontPointSize:      root.dense ? 23.25 : 25.5
    property double headingFontPointSize:       root.dense ? 16.5 : 18
    property double titleFontPointSize:         root.dense ? 13.5 : 15
    property double subHeadingFontPointSize:    root.dense ? 10.5 : 12
    property double listTextFontPointSize:      root.dense ? 10.5 : 12
    property double listSecTextFontPointSize:   root.dense ? 9 : 10.5
    property double overlineFontPointSize:      root.dense ? 7.5 : 8.5
    property double body2FontPointSize:         root.dense ? 9 : 10.5
    property double body1FontPointSize:         root.dense ? 9 : 10.5
    property double captionFontPointSize:       root.dense ? 8 : 9
    property double hintFontPointSize:          root.dense ? 7.5 : 8.5
    property double buttonFontPointSize:        root.dense ? 9 : 11
    property double menuFontPointSize:          root.dense ? 10.5 : 12
    property double menuHintFontPointSize:      root.dense ? 9 : 10.5

    property double display3FontPixelSize:      root.dense ? 50 : 56
    property double display2FontPixelSize:      root.dense ? 42 : 45
    property double display1FontPixelSize:      root.dense ? 32 : 34
    property double headingFontPixelSize:       root.dense ? 22 : 24
    property double titleFontPixelSize:         root.dense ? 19 : 20
    property double subHeadingFontPixelSize:    root.dense ? 15 : 16
    property double listTextFontPixelSize:      root.dense ? 15 : 16
    property double listSecTextFontPixelSize:   root.dense ? 13 : 14
    property double overlineFontPixelSize:      root.dense ? 10 : 11
    property double body2FontPixelSize:         root.dense ? 13 : 14
    property double body1FontPixelSize:         root.dense ? 13 : 14
    property double captionFontPixelSize:       root.dense ? 11 : 12
    property double hintFontPixelSize:          root.dense ? 10 : 11
    property double buttonFontPixelSize:        root.dense ? 13 : 14
    property double menuFontPixelSize:          root.dense ? 13 : 14
    property double menuHintFontPixelSize:      root.dense ? 11 : 12

    function textTypeToFontFamily(type)
    {
        switch(type)
        {
            case MaterialStyle.TextType.Display3:   return display3FontFamily;
            case MaterialStyle.TextType.Display2:   return display2FontFamily;
            case MaterialStyle.TextType.Display1:   return display1FontFamily;
            case MaterialStyle.TextType.Heading:    return headingFontFamily;
            case MaterialStyle.TextType.Title:      return titleFontFamily;
            case MaterialStyle.TextType.Subheading: return subHeadingFontFamily;
            case MaterialStyle.TextType.ListText:   return listTextFontFamily;
            case MaterialStyle.TextType.ListSecText:return listSecTextFontFamily;
            case MaterialStyle.TextType.Overline:   return overlineFontFamily;
            case MaterialStyle.TextType.Body2:      return body2FontFamily;
            case MaterialStyle.TextType.Body1:      return body1FontFamily;
            case MaterialStyle.TextType.Caption:    return captionFontFamily;
            case MaterialStyle.TextType.Hint:       return hintFontFamily;
            case MaterialStyle.TextType.Button:     return buttonFontFamily;
            case MaterialStyle.TextType.Menu:       return menuFontFamily;
            case MaterialStyle.TextType.MenuHint:   return menuHintFontFamily;
            default: break;
        }
        console.log("Unknown Text Type : " + type)
        return body1FontFamily;
    }

    function textTypeToStyleName(type)
    {
        switch(type)
        {
            case MaterialStyle.TextType.Display3:   return display3FontStyleName;
            case MaterialStyle.TextType.Display2:   return display2FontStyleName;
            case MaterialStyle.TextType.Display1:   return display1FontStyleName;
            case MaterialStyle.TextType.Heading:    return headingFontStyleName;
            case MaterialStyle.TextType.Title:      return titleFontStyleName;
            case MaterialStyle.TextType.Subheading: return subHeadingFontStyleName;
            case MaterialStyle.TextType.ListText:   return listTextFontStyleName;
            case MaterialStyle.TextType.ListSecText:return listSecTextFontStyleName;
            case MaterialStyle.TextType.Overline:   return overlineFontStyleName;
            case MaterialStyle.TextType.Body2:      return body2FontStyleName;
            case MaterialStyle.TextType.Body1:      return body1FontStyleName;
            case MaterialStyle.TextType.Caption:    return captionFontStyleName;
            case MaterialStyle.TextType.Hint:       return hintFontStyleName;
            case MaterialStyle.TextType.Button:     return buttonFontStyleName;
            case MaterialStyle.TextType.Menu:       return menuFontStyleName;
            case MaterialStyle.TextType.MenuHint:   return menuHintFontStyleName;
            default: break;
        }
        console.log("Unknown Text Type : " + type)
        return body1FontStyleName;
    }

    function textTypeToPointSize(type)
    {
        switch(type)
        {
            case MaterialStyle.TextType.Display3:   return display3FontPointSize;
            case MaterialStyle.TextType.Display2:   return display2FontPointSize;
            case MaterialStyle.TextType.Display1:   return display1FontPointSize;
            case MaterialStyle.TextType.Heading:    return headingFontPointSize;
            case MaterialStyle.TextType.Title:      return titleFontPointSize;
            case MaterialStyle.TextType.Subheading: return subHeadingFontPointSize;
            case MaterialStyle.TextType.ListText:   return listTextFontPointSize;
            case MaterialStyle.TextType.ListSecText:return listSecTextFontPointSize;
            case MaterialStyle.TextType.Overline:   return overlineFontPointSize;
            case MaterialStyle.TextType.Body2:      return body2FontPointSize;
            case MaterialStyle.TextType.Body1:      return body1FontPointSize;
            case MaterialStyle.TextType.Caption:    return captionFontPointSize;
            case MaterialStyle.TextType.Hint:       return hintFontPointSize;
            case MaterialStyle.TextType.Button:     return buttonFontPointSize;
            case MaterialStyle.TextType.Menu:       return menuFontPointSize;
            case MaterialStyle.TextType.MenuHint:   return menuHintFontPointSize;
            default: break;
        }
        console.log("Unknown Text Type : " + type)
        return body1FontPointSize;
    }

    function textTypeToPixelSize(type)
    {
        switch(type)
        {
            case MaterialStyle.TextType.Display3:   return display3FontPixelSize;
            case MaterialStyle.TextType.Display2:   return display2FontPixelSize;
            case MaterialStyle.TextType.Display1:   return display1FontPixelSize;
            case MaterialStyle.TextType.Heading:    return headingFontPixelSize;
            case MaterialStyle.TextType.Title:      return titleFontPixelSize;
            case MaterialStyle.TextType.Subheading: return subHeadingFontPixelSize;
            case MaterialStyle.TextType.ListText:   return listTextFontPixelSize;
            case MaterialStyle.TextType.ListSecText:return listSecTextFontPixelSize;
            case MaterialStyle.TextType.Overline:   return overlineFontPixelSize;
            case MaterialStyle.TextType.Body2:      return body2FontPixelSize;
            case MaterialStyle.TextType.Body1:      return body1FontPixelSize;
            case MaterialStyle.TextType.Caption:    return captionFontPixelSize;
            case MaterialStyle.TextType.Hint:       return hintFontPixelSize;
            case MaterialStyle.TextType.Button:     return buttonFontPixelSize;
            case MaterialStyle.TextType.Menu:       return menuFontPixelSize;
            case MaterialStyle.TextType.MenuHint:   return menuHintFontPixelSize;
            default: break;
        }
        console.log("Unknown Text Type : " + type)
        return body1FontPixelSize;
    }

    function textTypeToColor(type)
    {
        switch(type)
        {
            case MaterialStyle.TextType.Display3:   return displayTextColor();
            case MaterialStyle.TextType.Display2:   return displayTextColor();
            case MaterialStyle.TextType.Display1:   return displayTextColor();
            case MaterialStyle.TextType.Heading:    return primaryTextColor();
            case MaterialStyle.TextType.Title:      return primaryTextColor();
            case MaterialStyle.TextType.Subheading: return primaryTextColor();
            case MaterialStyle.TextType.ListText:   return primaryTextColor();
            case MaterialStyle.TextType.ListSecText:return secondaryTextColor();
            case MaterialStyle.TextType.Overline:   return secondaryTextColor();
            case MaterialStyle.TextType.Body2:      return primaryTextColor();
            case MaterialStyle.TextType.Body1:      return primaryTextColor();
            case MaterialStyle.TextType.Caption:    return secondaryTextColor();
            case MaterialStyle.TextType.Hint:       return hintTextColor();
            case MaterialStyle.TextType.Button:     return primaryTextColor();
            case MaterialStyle.TextType.Menu:       return primaryTextColor();
            case MaterialStyle.TextType.MenuHint:   return secondaryTextColor();
            default: break;
        }
        console.log("Unknown Text Type : " + type)
        return primaryTextColor();
    }

    function textTypeToColorReversed(type)
    {
        switch(type)
        {
            case MaterialStyle.TextType.Display3:   return displayTextColorReversed();
            case MaterialStyle.TextType.Display2:   return displayTextColorReversed();
            case MaterialStyle.TextType.Display1:   return displayTextColorReversed();
            case MaterialStyle.TextType.Heading:    return primaryTextColorReversed();
            case MaterialStyle.TextType.Title:      return primaryTextColorReversed();
            case MaterialStyle.TextType.Subheading: return primaryTextColorReversed();
            case MaterialStyle.TextType.ListText:   return primaryTextColorReversed();
            case MaterialStyle.TextType.ListSecText:return secondaryTextColorReversed();
            case MaterialStyle.TextType.Overline:   return secondaryTextColorReversed();
            case MaterialStyle.TextType.Body2:      return primaryTextColorReversed();
            case MaterialStyle.TextType.Body1:      return primaryTextColorReversed();
            case MaterialStyle.TextType.Caption:    return secondaryTextColorReversed();
            case MaterialStyle.TextType.Hint:       return hintTextColorReversed();
            case MaterialStyle.TextType.Button:     return primaryTextColorReversed();
            case MaterialStyle.TextType.Menu:       return primaryTextColorReversed();
            case MaterialStyle.TextType.MenuHint:   return secondaryTextColorReversed();
            default: break;
        }
        console.log("Unknown Text Type : " + type)
        return primaryTextColorReversed();
    }

    function fontCapitalization(type)
    {
        switch(type)
        {
            case MaterialStyle.TextType.Overline:
            case MaterialStyle.TextType.Button:
                return Font.AllUppercase;
            default: break;
        }
        return Font.MixedCase;
    }

    function textTypeToLetterSpacing(type)
    {
        switch(type)
        {
            case MaterialStyle.TextType.Overline:
                return 2;
            case MaterialStyle.TextType.ListSecText:
                return 0.4;
            default: break;
        }
        return 0;
    }

    property var rawButton: QtObject
    {
        property double minWidth:                   root.dense ? 52 : 64
        property double minHeight:                  root.dense ? 24 : 36
        property double padding:                    root.dense ? 7 : 16
        property double iconPadding:                root.dense ? 6 : 12
        property double spacing:                    root.dense ? 4 : 8
        property double iconWidth:                  root.dense ? 14 : 18
        property double cornerRadius:               root.dense ? 2 : 4

        property double defaultElevation:           2
        property double flatElevation:              0
        property double defaultPressedElevation:    root.dense ? 6 : 8
        property double flatPressedElevation:       root.dense ? 1 : 2

        property double topInset:                   root.dense ? 4 : 6
        property double bottomInset:                root.dense ? 4 : 6
        property double leftInset:                  root.dense ? 2 : 4
        property double rightInset:                 root.dense ? 2 : 4

        property double outlinedWidth:              1
        property double outlinedFocusWidth:         root.dense ? 1 : 2
    } // QtObject

    enum FabType
    {
        Default,
        Mini,
        Extended
    }

    property var fab: QtObject
    {
        property double minWidth:                   root.dense ? 44 : 56
        property double minWidthMini:               root.dense ? 32 : 40
        property double minWidthExtended:           root.dense ? 52 : 64
        property double minHeightExtended:          minWidth//root.dense ? 34 : 48

        property double flatInset:                  root.dense ? 2 : 4
        property double flatInsetNoClip:            root.dense ? 5 : 10

        property double padding:                    root.dense ? 8 : 16
        property double paddingMini:                root.dense ? 4 : 8
        property double iconPadding:                root.dense ? 8 : 12
        property double textPadding:                root.dense ? 12 : 20

        property double spacing:                    root.dense ? 8 : 12
        property double iconWidth:                  root.dense ? 18 : 24

/*        property double fontPointSize:              root.buttonFontPointSize
        property int fontCapitalisation:            Font.AllUppercase
        property string fontFamily:                 root.fontFamily
        property string fontStyleName:              "Medium"*/

        property double elevation:                  root.dense ? 4 : 6
        property double pressedElevation:           root.dense ? 10 : 12

        property double anchorsOffset:              root.dense ? 10 : 16
    } // QtObject

    property var toolbar: QtObject
    {
        property double implicitHeight:             root.dense ? 38 : 48
        property double elevation:                  root.dense ? 3 : 4
    }

    property var toolButton: QtObject
    {
        property double minWidth:                   root.dense ? 28 : 36
        property double minHeight:                  root.dense ? 28 : 36

        property double appBarButtonWidth:          root.dense ? 24 : 30
        property double appBarButtonHeight:         root.dense ? 24 : 30

        property double padding:                    root.dense ? 7 : 9

        property double spacing:                    root.dense ? 8 : 12
        property double iconWidth:                  root.dense ? 18 : 24

        property double topInset:                   root.dense ? 2 : 6
        property double bottomInset:                root.dense ? 2 : 6
        property double leftInset:                  root.dense ? 1 : 2
        property double rightInset:                 root.dense ? 1 : 2

        property double elevation:                  root.dense ? 0 : 0
        property double pressedElevation:           root.dense ? 0 : 0

        property double separatorLargePadding:      root.dense ? 3 : 6
        property double separatorSmallPadding:      root.dense ? 2 : 5
        property double separatorImplicitWidth:     root.dense ? 24 : 38
    } // QtObject

    property var tabBar: QtObject
    {
        property double elevation:                  10
        property double highlightHeight:            root.dense ? 2 : 2
        property double minHeight:                  root.dense ? 38 : 48
        property double minLeftWidth:               root.dense ? 40 : 52
        property double minTabWidth:                root.dense ? 96 : 127
        property double maxTabWidth:                root.dense ? 200 : 360
    } // QtObject

    property var tabButton: QtObject
    {
        property double minWidth:                   root.dense ? 70 : 90
        property double minHeight:                  root.dense ? 30 : 48
        property double minHeightWithIcon:          root.dense ? 50 : 72
        property double minHeightWithSmallIcon:     root.dense ? 42 : 48
        property double padding:                    root.dense ? 8 : 16

        property double spacing:                    root.dense ? 3 : 6
        property double smallSpacing:               root.dense ? 2 : 3
        property double spacingVertical:            root.dense ? 12 : 15
        property double smallSpacingVertical:       root.dense ? 11 : 14

        property double topPadding:                 root.dense ? 6 : 12
        property double smallTopPadding:            root.dense ? 3 : 6
        property double iconPadding:                root.dense ? 6 : 12
        property double iconWidth:                  root.dense ? 18 : 24

        property double topInset:                   root.dense ? 0 : 0
        property double bottomInset:                root.dense ? 0 : 0
        property double leftInset:                  root.dense ? 0 : 0
        property double rightInset:                 root.dense ? 0 : 0
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
    }

    property var delegate: QtObject
    {
        property double implicitWidth:             root.dense ? 160 : 200
        function implicitHeight1Line(type)
        {
            switch(type)
            {
                case MaterialStyle.DelegateType.Overline:
                    return                          root.dense ? 52 : 64
                case MaterialStyle.DelegateType.Icon:
                case MaterialStyle.DelegateType.Round:
                     return                         root.dense ? 44 : 56
                case MaterialStyle.DelegateType.Square:
                case MaterialStyle.DelegateType.Large:
                    return                          root.dense ? 58 : 72
                default: break
            }
            return                                  root.dense ? 38 : 48
        }

        function implicitHeight2Line(type)
        {
            switch(type)
            {
                case MaterialStyle.DelegateType.Overline:
                    return                          root.dense ? 70 : 88
                case MaterialStyle.DelegateType.Icon:
                case MaterialStyle.DelegateType.Round:
                case MaterialStyle.DelegateType.Square:
                case MaterialStyle.DelegateType.Large:
                    return                          root.dense ? 62 : 72
                default: break
            }
            return                                  root.dense ? 52 : 64
        }

        function implicitHeight3Line(type)
        {
            return                                  root.dense ? 70 : 88
        }

        function implicitHeight(type, lines)
        {
            switch(lines)
            {
                case 2: return implicitHeight2Line(type)
                case 3: return implicitHeight3Line(type)
                default: return implicitHeight1Line(type)
            }
        }

        function spacing(type, lines)
        {
            if(lines === 3)
            {
                switch(type)
                {
                    case MaterialStyle.DelegateType.Icon:
                        return                      root.dense ? 26 : 32
                    case MaterialStyle.DelegateType.Round:
                    case MaterialStyle.DelegateType.Square:
                        return                      root.dense ? 12 : 16
                    case MaterialStyle.DelegateType.Large:
                        return                      root.dense ? 16 : 20
                    default: break
                }
                return 0;
            }
            else
            {
                switch(type)
                {
                    case MaterialStyle.DelegateType.Icon:
                        return                      root.dense ? 26 : 32
                    case MaterialStyle.DelegateType.Round:
                    case MaterialStyle.DelegateType.Square:
                    case MaterialStyle.DelegateType.Large:
                        return                      root.dense ? 12 : 16
                    default: break
                }
                return 0;
            }
        }

        function topPadding1Line(type, lines)
        {
            switch(type)
            {
                case MaterialStyle.DelegateType.Icon:
                    return                          root.dense ? 12 : 16
                case MaterialStyle.DelegateType.Round:
                    return                          root.dense ? 6 : 8
                case MaterialStyle.DelegateType.Square:
                case MaterialStyle.DelegateType.Large:
                    return                          root.dense ? 7 : 8
                default: break
            }
            return                                  0
        }

        function topPadding2Line(type, lines)
        {
            switch(type)
            {
                case MaterialStyle.DelegateType.Icon:
                    return                          root.dense ? 20 : 24
                case MaterialStyle.DelegateType.Round:
                    return                          root.dense ? 12 : 16
                case MaterialStyle.DelegateType.Square:
                case MaterialStyle.DelegateType.Large:
                    return                          root.dense ? 9 : 8
                default: break
            }
                return                              0
        }

        function topPadding3Line(type, lines)
        {
            switch(type)
            {
                case MaterialStyle.DelegateType.Icon:
                case MaterialStyle.DelegateType.Round:
                case MaterialStyle.DelegateType.Square:
                case MaterialStyle.DelegateType.Large:
                    return                          root.dense ? 12 : 16
                default: break
            }
            return                                  0
        }

        function topPadding(type, lines)
        {
            switch(lines)
            {
                case 2:                             return topPadding2Line(type)
                case 3:                             return topPadding3Line(type)
                default:                            return topPadding1Line(type)
            }
        }

        function leftPadding(type, lines)
        {
            if(type === MaterialStyle.DelegateType.Large)
                return                              0
            return                                  root.dense ? 12 : 16
        }

        function rightPadding(type, lines)
        {
            return                                  root.dense ? 12 : 16
        }

        function baselineOffsetText(type, lines)
        {
            if(type === MaterialStyle.DelegateType.Overline)
                return                                  root.dense ? 38 : 48
            else if(lines === 2)
            {
                switch(type)
                {
                    case MaterialStyle.DelegateType.Icon:
                    case MaterialStyle.DelegateType.Round:
                    case MaterialStyle.DelegateType.Square:
                    case MaterialStyle.DelegateType.Large:
                        return                          root.dense ? 26 : 32
                    default: break
                }
                return                                  root.dense ? 22 : 28
            }
            else if(lines >= 3)
            {
                return                                  root.dense ? 22 : 28
            }
            return 0
        }

        function baselineOffsetSecText(type, lines)
        {
            if(type === MaterialStyle.DelegateType.Overline)
                return                                  root.dense ? 53 : 70
            else if(lines === 2)
            {
                switch(type)
                {
                    case MaterialStyle.DelegateType.Icon:
                    case MaterialStyle.DelegateType.Round:
                    case MaterialStyle.DelegateType.Square:
                    case MaterialStyle.DelegateType.Large:
                        return                          root.dense ? 42 : 52
                    default: break
                }
                return                                  root.dense ? 38 : 48
            }
            else if(lines >= 3)
            {
                return                                  root.dense ? 38 : 48
            }
            return 0
        }

        function baselineOffsetOverline(lines)
        {
            return                                  root.dense ? 20 : 28
        }

        function roundWidth(large) { return squareWidth(large) }
        function squareWidth(large) { return large ? (root.dense ? 44 : 56) : (root.dense ? 32 : 40)}
        function largeWidth() { return root.dense ? 80 : 100 }

        function largeHeight(lines) { return (root.dense ? 44 : 56) }

        property double iconWidth:                  root.dense ? 20 : 24
        property double indicatorPadding:           root.dense ? 12 : 16

    }

    property var debug: QtObject
    {
        property bool drawDebugButton:              false
        property bool drawDebugIconLabel:           false
        property bool drawDebugDelegate:            false
    }

    property var switchIndicator: QtObject
    {
        property color switchCheckedTrackColor: Qt.rgba(MaterialStyle.accentColor.r, MaterialStyle.accentColor.g, MaterialStyle.accentColor.b, 0.5)
        property color switchUncheckedTrackColor: MaterialStyle.dividersColor()
        property color switchDisabledTrackColor: MaterialStyle.disabledDividersColor()

        property color switchCheckedHandleColor: MaterialStyle.accentColor
        property color switchUncheckedHandleColor: MaterialStyle.theme === MaterialStyle.Theme.Light ? MaterialStyle.primaryTextColorDark : MaterialStyle.secondaryTextColorDark
        property color switchDisabledHandleColor: Qt.darker(switchUncheckedHandleColor, (MaterialStyle.theme === MaterialStyle.Theme.Light) ? 1.25 : 1.6)

        property double implicitWidth:              root.dense ? 30 : 38
        property double implicitHeight:             root.dense ? 26 : 32
        property double trackHeight:                root.dense ? 12 : 14
        property double handleRadius:               root.dense ? 16 : 20
    }

    property var radioIndicator: QtObject
    {
        property double implicitWidth:              root.dense ? 16 : 20
        property double implicitHeight:             root.dense ? 16 : 20
    }

    property var checkIndicator: QtObject
    {
        property double implicitWidth:              root.dense ? 16 : 18
        property double implicitHeight:             root.dense ? 16 : 18
        property double iconWidth:                  root.dense ? 16 : 19
        property double radius:                     2
        property double partiallyCheckedWidth:      root.dense ? 10 : 12
        property double partiallyCheckedHeight:     root.dense ? 2 : 3
    }

    property var switchButton: QtObject
    {
        property double horizontalPadding:          root.dense ? 6 : 8
        property double verticalPadding:            root.dense ? 4 : 8
        property double spacing:                    root.dense ? 8 : 12
        property double rippleWidth:                root.dense ? 24 : 28
    }

    property var checkButton: QtObject
    {
        property double horizontalPadding:          root.dense ? 6 : 8
        property double verticalPadding:            root.dense ? 6 : 14
        property double spacing:                    root.dense ? 8 : 12
        property double rippleWidth:                root.dense ? 24 : 28
    }

    property var radioButton: QtObject
    {
        property double horizontalPadding:          root.dense ? 6 : 8
        property double verticalPadding:            root.dense ? 6 : 14
        property double spacing:                    root.dense ? 8 : 12
        property double rippleWidth:                root.dense ? 18 : 28
    }

    property var menu : QtObject
    {
        property double elevation:                  root.dense ? 6 : 8
        property double verticalPadding:            root.dense ? 2 : 8
        property double implicitHeight:             root.dense ? 28 : 38
        property double implicitWidth:              root.dense ? 160 : 200
        property double radius:                     root.dense ? 0 : 0
        property double separatorWLargePadding:     root.dense ? 28 : 40
        property double separatorWSmallPadding:     root.dense ? 4 : 8
        property double separatorHSmallPadding:     root.dense ? 2 : 4
        property double separatorImplicitWidth:     root.dense ? 150 : 200
    }

    property var menuBarItem: QtObject
    {
        property double minWidth:                   root.dense ? 54 : 64
        property double minHeight:                  root.dense ? 24 : 32
        property double padding:                    root.dense ? 4 : 6
        property double iconPadding:                root.dense ? 2 : 4
        property double spacing:                    root.dense ? 2 : 4
        property double iconWidth:                  root.dense ? 14 : 18
        property double cornerRadius:               root.dense ? 2 : 4

        property double topInset:                   root.dense ? 2 : 4
        property double bottomInset:                root.dense ? 2 : 4
        property double leftInset:                  root.dense ? 0 : 0
        property double rightInset:                 root.dense ? 0 : 0
    } // QtObject

    property var menuItem: QtObject
    {
        property double minWidth:                   root.dense ? 160 : 200
        property double minHeight:                  root.dense ? 24 : 32
        property double padding:                    root.dense ? 8 : 12
        property double iconPadding:                root.dense ? 8 : 12
        property double spacing:                    root.dense ? 10 : 16
        property double iconWidth:                  root.dense ? 14 : 18
        property double cornerRadius:               root.dense ? 0 : 0
        property double shortcutImplicitWidth:      root.dense ? 74 : 96

        property double topInset:                   root.dense ? 0 : 0
        property double bottomInset:                root.dense ? 0 : 0
        property double leftInset:                  root.dense ? 1 : 2
        property double rightInset:                 root.dense ? 1 : 2
    } // QtObject

    property var scroll: QtObject
    {
        property double implicitWidth:              root.dense ? 7 : 12
        property double implicitWidthBackground:    root.dense ? 7 : 12
        property double implicitWidthInactive:      root.dense ? 2 : 4
        property double radius:                     root.dense ? 2 : 4
        property double padding:                    root.dense ? 4 : 4
    } // QtObjects

    property var card: QtObject
    {
        property double horizontalPadding:          root.dense ? 12 : 16
        property double verticalPadding:            root.dense ? 6 : 8
        property double radius:                     root.dense ? 3 : 4
        property double defaultElevation:           root.dense ? 1 : 1
        property double activeElevation:            root.dense ? 6 : 8
        property double spacing:                    root.dense ? 4 : 6

        property double roundImageSpacing:          root.dense ? 12 : 16
        property double roundImageSize:             root.dense ? 32 : 40

        property double mediaImplicitWidth:         root.dense ? 276 : 344
        property double mediaImplicitHeight:        root.dense ? 156 : 194
    } // QtObject

    property var banner: QtObject
    {
        property double minimumWidth:               root.dense ? 288 : 360
        property double smallTextPadding:           root.dense ? 28 : 36
        property double smallTextPaddingDesktop:    root.dense ? 72 : 90

        property double mobileMaxWidth:             root.dense ? 520 : 650

        property double implicitHeight1Line:        root.dense ? 44 : 54
        property double implicitHeight2Line:        root.dense ? 90 : 112
        property double implicitHeightThumb:        root.dense ? 96 : 120
        property double implicitHeight1LineDesk:    root.dense ? 42 : 52
        property double implicitHeight2LineDesk:    root.dense ? 58 : 72
        property double implicitHeight3LineDesk:    root.dense ? 72 : 90
    } // QtObject

    property var roundIcon: QtObject
    {
        property double size:                       root.dense ? 32 : 40
        property double iconWidth:                  root.dense ? 18 : 24
    }

    property var snackbar: QtObject
    {
        property double implicitWidth:              root.dense ? 276 : 344
        property double implicitHeight:             root.dense ? 38 : 48
        property double implicitHeight2:            root.dense ? 54 : 68
        property double radius:                     root.dense ? 3 : 4
        property double elevation:                  6
        property double shortDisplayTime:           2000
        property double longDisplayTime:            5000
    } // snackbar

    property var textField: QtObject
    {
        property double cursorWidth:                root.dense ? 2 : 2
        property double implicitWidth:              root.dense ? 96 : 120
        property double horizontalPadding:          0//root.dense ? 12 : 16
        property double leadingSpacing:             root.dense ? 12 : 16
        property double textSpacing:                root.dense ? 2 : 4

        property double topPadding:                 root.dense ? 6 : 8
        property double topPaddingTitle:            root.dense ? 18 : 22
        property double topPaddingTitleOffset:      root.dense ? 2 : 4
        property double bottomPadding:              root.dense ? 8 : 10
        property double bottomPaddingHint:          root.dense ? 24 : 28
        property double bottomPaddingHintOffset:    root.dense ? 2 : 4

        property double iconSize:                   root.dense ? 20 : 24
        property double iconWidth:                  root.dense ? 32 : 40

        // background
        property double backgroundBorderHeight:     root.dense ? 2 : 2
        property double backgroundVerticalOffset:   root.dense ? 6 : 8
    } // textField

    property var dialog: QtObject
    {
        property double spacing:                    0
        property double padding:                    root.dense ? 2 : 4
        property double buttonRectImplicitHeight:   root.dense ? 42 : 52
        property double radius:                     root.dense ? 2 : 4
        property double horizontalPadding:          root.dense ? 18 : 24
        property double topPadding:                 root.dense ? 16 : 20
        property double elevation:                  root.dense ? 18 : 24
        property double implicitWidth:              root.dense ? 224 : 280
        property double maxHeight:                  root.dense ? 500 : 500
        property double indicatorSpacing:           root.dense ? 18 : 24
    } // dialog
}
