/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

Rectangle
{
  implicitHeight: Qaterial.Style.delegate.implicitHeight(type, lines)
  implicitWidth: 200

  property alias rippleWidth: _ripple.width
  property alias rippleHeight: _ripple.height
  property alias rippleX: _ripple.x
  property alias rippleY: _ripple.y

  color: highlighted ? Qt.rgba(Qaterial.Style.accentColor.r, Qaterial.Style.accentColor.g, Qaterial.Style.accentColor.b,
    0.2) : (transparentBackground ? "transparent" : Qaterial.Style.backgroundColor)

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

  Qaterial.Ripple
  {
    id: _ripple
    width: parent.width
    height: parent.height

    clip: visible
    color: Qaterial.Style.rippleColor(parent.onPrimary ? Qaterial.Style.RippleBackground.Primary : Qaterial.Style
      .RippleBackground.Background)
  } // Ripple
} // Rectangle
