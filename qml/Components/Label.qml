/** 
 * Copyright (C) Olivier Le Doeuff 2019 
 * Contact: olivier.ldff@gmail.com 
 */

import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12

import QQuickMaterialHelper.Style 1.12

T.Label
{
    id: control

    color: enabled ? (colorReversed ? MaterialStyle.textTypeToColorReversed(textType) : MaterialStyle.textTypeToColor(textType)) : MaterialStyle.hintTextColor()
    linkColor: MaterialStyle.accentColor

    property int textType: MaterialStyle.TextType.Body1
    property bool onPrimary: false
    property bool colorReversed: onPrimary && MaterialStyle.shouldReverseForegroundOnPrimary

    font.family: MaterialStyle.textTypeToFontFamily(textType)
    font.styleName: MaterialStyle.textTypeToStyleName(textType)
    //font.weight: Font.Medium
    font.pixelSize: MaterialStyle.textTypeToPixelSize(textType)
    font.capitalization: MaterialStyle.fontCapitalization(textType)
    font.letterSpacing:  MaterialStyle.textTypeToLetterSpacing(textType)
} // Label
