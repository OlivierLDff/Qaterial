/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

import QtQuick 2.12

// Qaterial
import Qaterial 1.0

ColorIcon
{
	id: root
    property bool highlighted: true
    property bool reverseHighlight: false
    property bool onPrimary: false
    property bool colorReversed: onPrimary && Style.shouldReverseForegroundOnPrimary
    property bool enabled: true

    iconSize: Style.roundIcon.iconWidth
	roundSize: Style.roundIcon.size

	width: roundSize
	height: roundSize

    roundOpacity: !(fill && highlighted && reverseHighlight) || !enabled

    color: enabled ? (fill && highlighted && reverseHighlight ? (Style.shouldReverseForegroundOnAccent ? Style.primaryTextColorReversed() : Style.primaryTextColor()) : (highlighted ? Style.accentColor : Style.primaryTextColor())) : (colorReversed ? Style.disabledTextColorReversed() : Style.disabledTextColor())

    roundColor: !fill ? "transparent" : enabled ?
    	(highlighted && reverseHighlight ? Style.accentColor : (colorReversed ? Style.disabledDividersColorReversed() : Style.disabledDividersColor())) :
    	(colorReversed ? Style.disabledDividersColorReversed() : Style.disabledDividersColor())

    roundBorderColor: !outlined ? "transparent" : enabled ?
    	(highlighted && reverseHighlight ? Style.accentColor : (colorReversed ? Style.disabledDividersColorReversed() : Style.disabledDividersColor())) :
    	(colorReversed ? Style.disabledDividersColorReversed() : Style.disabledDividersColor())
}
