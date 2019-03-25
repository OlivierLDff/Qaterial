import QtQuick 2.12
import QtGraphicalEffects 1.12

Item
{
	id: root

	// ICON CONTROL
	property alias source: control.source
	property bool fill: false
	property bool outlined: false
	property bool roundIcon: fill || outlined
	property alias mirror: control.mirror
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
		width: root.roundSize
		height: root.roundSize
		color: root.fill ? root.roundColor : "transparent"
		radius: root.roundSize/2
		visible: root.roundIcon
		border.width: root.outlined ? 1 : 0
		border.color: root.outlined ? root.roundBorderColor : "transparent"
		opacity: roundOpacity ? 0.5 : 1.0
	} // Rectangle

	Image
	{
	    id: control
	    width: root.iconSize
	    height: root.iconSize
	    visible: false
		fillMode: Image.PreserveAspectFit
		sourceSize.height: root.iconSize
		sourceSize.width: root.iconSize
		anchors.centerIn: parent
	} // Image

	ColorOverlay 
	{
		source: control
		anchors.fill: control
		color.r: root.color.r
		color.g: root.color.g
		color.b: root.color.b
		color.a: 1
		cached : true
	} // ColorOverlay

	opacity: color.a
}