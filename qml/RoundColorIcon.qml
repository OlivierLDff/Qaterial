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
    property bool colorReversed: onPrimary && MaterialStyle.shouldReverseForegroundOnPrimary
    property bool enabled: true

    iconSize: MaterialStyle.roundIcon.iconWidth
	roundSize: MaterialStyle.roundIcon.size

	width: roundSize
	height: roundSize

    roundOpacity: !(fill && highlighted && reverseHighlight) || !enabled

    color: enabled ? (fill && highlighted && reverseHighlight ? (MaterialStyle.shouldReverseForegroundOnAccent ? MaterialStyle.primaryTextColorReversed() : MaterialStyle.primaryTextColor()) : (highlighted ? MaterialStyle.accentColor : MaterialStyle.primaryTextColor())) : (colorReversed ? MaterialStyle.disabledTextColorReversed() : MaterialStyle.disabledTextColor())

    roundColor: !fill ? "transparent" : enabled ?
    	(highlighted && reverseHighlight ? MaterialStyle.accentColor : (colorReversed ? MaterialStyle.disabledDividersColorReversed() : MaterialStyle.disabledDividersColor())) :
    	(colorReversed ? MaterialStyle.disabledDividersColorReversed() : MaterialStyle.disabledDividersColor())

    roundBorderColor: !outlined ? "transparent" : enabled ?
    	(highlighted && reverseHighlight ? MaterialStyle.accentColor : (colorReversed ? MaterialStyle.disabledDividersColorReversed() : MaterialStyle.disabledDividersColor())) :
    	(colorReversed ? MaterialStyle.disabledDividersColorReversed() : MaterialStyle.disabledDividersColor())
}
