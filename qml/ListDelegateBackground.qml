import QtQuick 2.12

// Qaterial
import Qaterial 1.0

Rectangle
{
    implicitHeight: Style.delegate.implicitHeight(type, lines)
    implicitWidth: 200

    property alias rippleWidth: _ripple.width
    property alias rippleHeight: _ripple.height
    property alias rippleX: _ripple.x
    property alias rippleY: _ripple.y

    color: highlighted ? Qt.rgba(Style.accentColor.r, Style.accentColor.g, Style.accentColor.b, 0.2) : (transparentBackground ? "transparent" : Style.backgroundColor)

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

        clip: visible
        color: Style.rippleColor(parent.onPrimary ? Style.RippleBackground.Primary : Style.RippleBackground.Background)
    }
} // Rectangle
