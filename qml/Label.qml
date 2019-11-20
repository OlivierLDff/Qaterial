/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12

// Qaterial
import Qaterial 1.0

T.Label
{
    id: control

    color: enabled ? (colorReversed ? Style.textTypeToColorReversed(textType) : Style.textTypeToColor(textType)) : Style.hintTextColor()
    linkColor: Style.accentColor

    property int textType: Style.TextType.Body1
    property bool onPrimary: false
    property bool colorReversed: onPrimary && Style.shouldReverseForegroundOnPrimary
    property bool usePixelSize: Style.usePixelSize

    property double pixelSize: Style.textTypeToPixelSize(textType)
    property double pointSize: Style.textTypeToPointSize(textType)

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

    font.family: Style.textTypeToFontFamily(textType)
    font.styleName: Style.textTypeToStyleName(textType)
    font.capitalization: Style.fontCapitalization(textType)
    font.letterSpacing: Style.textTypeToLetterSpacing(textType)
} // Label
