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
    property bool usePixelSize: MaterialStyle.usePixelSize

    property double pixelSize: MaterialStyle.textTypeToPixelSize(textType)
    property double pointSize: MaterialStyle.textTypeToPointSize(textType)

    Binding on font.pixelSize 
    {
        when: control.usePixelSize
        value: control.pixelSize
    }

    Binding on font.pointSize 
    {
        when: !control.usePixelSize
        value: control.pointSize
    }

    font.family: MaterialStyle.textTypeToFontFamily(textType)
    font.styleName: MaterialStyle.textTypeToStyleName(textType)
    font.capitalization: MaterialStyle.fontCapitalization(textType)
    font.letterSpacing: MaterialStyle.textTypeToLetterSpacing(textType)
} // Label
