/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtGraphicalEffects 1.12

Item
{
	id: _root

	// ICON CONTROL
	property alias source: _control.source
	property bool fill: false
	property bool outlined: false
	property bool roundIcon: fill || outlined
	property alias mirror: _control.mirror
	property bool roundOpacity: true

	// COLORS
	property color color
	property color roundColor
	property color roundBorderColor: roundColor

	// SIZE
	width: roundIcon ? roundSize : iconSize
	height: roundIcon ? roundSize : iconSize

	property double iconSize: 24
	property double roundSize: 40

	Rectangle
	{
		id: _round
		width: _root.roundSize
		height: _root.roundSize
		color: _root.fill ? _root.roundColor : "transparent"
		radius: _root.roundSize/2
		visible: _root.roundIcon
		border.width: _root.outlined ? 1 : 0
		border.color: _root.outlined ? _root.roundBorderColor : "transparent"
		opacity: roundOpacity ? 0.5 : 1.0
	} // Rectangle

	Image
	{
		id: _control
		width: _root.iconSize
		height: _root.iconSize
		visible: false
		fillMode: Image.PreserveAspectFit
		sourceSize.height: _root.iconSize
		sourceSize.width: _root.iconSize
		anchors.centerIn: parent
	} // Image

	ColorOverlay
	{
		source: _control
		anchors.fill: _control
		color.r: _root.color.r
		color.g: _root.color.g
		color.b: _root.color.b
		color.a: 1
		cached : true
	} // ColorOverlay

	opacity: color.a
} // Item
