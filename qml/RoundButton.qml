/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

import QtQuick 2.12

import Qaterial.Style 1.12
import Qaterial.Components 1.12

RawMaterialButton
{
	id: control
    flat: true
    highlighted: checked
    clipRipple: false

    icon.width: MaterialStyle.fab.iconWidth
    icon.height: MaterialStyle.fab.iconWidth

    leftPadding: MaterialStyle.fab.iconPadding
	rightPadding: leftPadding
	//topPadding: 0
	//bottomPadding: 0

	//topInset: 0
	//bottomInset: 0
	//leftInset: MaterialStyle.fab.iconPadding
	//rightInset: MaterialStyle.fab.iconPadding

    backgroundImplicitWidth: MaterialStyle.toolButton.minWidth /*- Math.max(leftInset + rightInset, topInset + bottomInset)*/
	backgroundImplicitHeight: MaterialStyle.toolButton.minHeight /*- Math.max(leftInset + rightInset, topInset + bottomInset)*/

	property bool onPrimary: false
	property bool colorReversed: onPrimary && MaterialStyle.shouldReverseForegroundOnPrimary

	property bool accentColorAuthorized: (onPrimary && MaterialStyle.preferAccentOnPrimary || !onPrimary)

	foregroundColor: !enabled ? (colorReversed ? MaterialStyle.disabledTextColorReversed() : MaterialStyle.disabledTextColor()) :
					highlighted && accentColorAuthorized ? MaterialStyle.accentColor :
					!highlighted && !accentColorAuthorized ? (colorReversed ? MaterialStyle.secondaryTextColorReversed() : MaterialStyle.secondaryTextColor()) :
					colorReversed ? MaterialStyle.primaryTextColorReversed() : MaterialStyle.primaryTextColor()

	property double animationSpeed: 0
	onCheckedChanged: animationSpeed = checked ? 0 : 300

    Behavior on foregroundColor { ColorAnimation { easing.type: Easing.InOutQuad; duration: control.animationSpeed } }
    Behavior on backgroundColor { ColorAnimation { easing.type: Easing.InOutQuad; duration: control.animationSpeed } }
} // RawMaterialButton
