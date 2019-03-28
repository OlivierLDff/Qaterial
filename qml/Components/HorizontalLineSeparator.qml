/** 
 * Copyright (C) Olivier Le Doeuff 2019 
 * Contact: olivier.ldff@gmail.com 
 */

import QtQuick 2.12

import QQuickMaterialHelper.Style 1.12

Rectangle 
{
    implicitWidth: MaterialStyle.menu.separatorImplicitWidth
    implicitHeight: 1
    property bool enabled: true
    color: !enabled ? (colorReversed ? MaterialStyle.disabledDividersColorReversed() : MaterialStyle.disabledDividersColor()) :
                highlighted && accentColorAuthorized ? MaterialStyle.accentColor :
                colorReversed ? MaterialStyle.dividersColorReversed() : MaterialStyle.dividersColor()

    property bool highlighted: false
    property bool onPrimary: false
    property bool colorReversed: onPrimary && MaterialStyle.shouldReverseForegroundOnPrimary
    property bool accentColorAuthorized: onPrimary && MaterialStyle.preferAccentOnPrimary
} // Rectangle