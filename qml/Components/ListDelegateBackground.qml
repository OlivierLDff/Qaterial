import QtQuick 2.12

import QQuickMaterialHelper.Style 1.12
import QQuickMaterialHelper.Core 1.12

Rectangle 
{
    implicitHeight: MaterialStyle.delegate.implicitHeight(type, lines)
    implicitWidth: 200

    property alias rippleWidth: _ripple.width
    property alias rippleHeight: _ripple.height
    property alias rippleX: _ripple.x
    property alias rippleY: _ripple.y

    color: highlighted ? Qt.rgba(MaterialStyle.accentColor.r, MaterialStyle.accentColor.g, MaterialStyle.accentColor.b, 0.2) : (transparentBackground ? "transparent" : MaterialStyle.backgroundColor)

    property alias pressed: _ripple.pressed
    property alias rippleActive: _ripple.active
    property alias rippleColor: _ripple.color
    property alias rippleAnchor: _ripple.anchor
    property alias enabled: _ripple.enabled
    property bool transparentBackground: true
    property bool onPrimary: false
    property bool highlighted: false
    property int type
    property int lines

    Ripple 
    {
        id: _ripple
        width: parent.width
        height: parent.height
        onXChanged: console.log("x: " + x)

        clip: visible
        color: MaterialStyle.rippleColor(parent.onPrimary ? MaterialStyle.RippleBackground.Primary : MaterialStyle.RippleBackground.Background)
    }
} // Rectangle