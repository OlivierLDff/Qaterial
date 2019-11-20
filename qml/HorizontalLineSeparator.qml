/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12

// Qaterial
import Qaterial 1.0

Rectangle
{
    implicitWidth: Style.menu.separatorImplicitWidth
    implicitHeight: 1
    property bool enabled: true
    color: !enabled ? (colorReversed ? Style.disabledDividersColorReversed() : Style.disabledDividersColor()) :
                highlighted && accentColorAuthorized ? Style.accentColor :
                colorReversed ? Style.dividersColorReversed() : Style.dividersColor()

    property bool highlighted: false
    property bool onPrimary: false
    property bool colorReversed: onPrimary && Style.shouldReverseForegroundOnPrimary
    property bool accentColorAuthorized: onPrimary && Style.preferAccentOnPrimary
} // Rectangle
