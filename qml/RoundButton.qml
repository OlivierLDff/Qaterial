/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

import QtQuick 2.12

import Qaterial 1.0

RawMaterialButton
{
	id: control
    flat: true
    highlighted: checked
    clipRipple: false

    icon.width: Style.fab.iconWidth
    icon.height: Style.fab.iconWidth

    leftPadding: Style.fab.iconPadding
	rightPadding: leftPadding
	//topPadding: 0
	//bottomPadding: 0

	//topInset: 0
	//bottomInset: 0
	//leftInset: Style.fab.iconPadding
	//rightInset: Style.fab.iconPadding

    backgroundImplicitWidth: Style.toolButton.minWidth /*- Math.max(leftInset + rightInset, topInset + bottomInset)*/
	backgroundImplicitHeight: Style.toolButton.minHeight /*- Math.max(leftInset + rightInset, topInset + bottomInset)*/

	property bool onPrimary: false
	property bool colorReversed: onPrimary && Style.shouldReverseForegroundOnPrimary

	property bool accentColorAuthorized: (onPrimary && Style.preferAccentOnPrimary || !onPrimary)

	foregroundColor: !enabled ? (colorReversed ? Style.disabledTextColorReversed() : Style.disabledTextColor()) :
					highlighted && accentColorAuthorized ? Style.accentColor :
					!highlighted && !accentColorAuthorized ? (colorReversed ? Style.secondaryTextColorReversed() : Style.secondaryTextColor()) :
					colorReversed ? Style.primaryTextColorReversed() : Style.primaryTextColor()

	property double animationSpeed: 0
	onCheckedChanged: animationSpeed = checked ? 0 : 300

    Behavior on foregroundColor { ColorAnimation { easing.type: Easing.InOutQuad; duration: control.animationSpeed } }
    Behavior on backgroundColor { ColorAnimation { easing.type: Easing.InOutQuad; duration: control.animationSpeed } }
} // RawMaterialButton
