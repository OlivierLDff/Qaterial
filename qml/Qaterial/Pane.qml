/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Templates 2.12 as T

// Qaterial
import Qaterial 1.0 as Qaterial

T.Pane
{
  id: control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    contentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    contentHeight + topPadding + bottomPadding)

  //padding: Qaterial.Style.card.horizontalPadding

  property bool onPrimary: false
  property bool colorReversed: onPrimary && Qaterial.Style.shouldReverseForegroundOnPrimary

  property double elevation: 0
  property color color: control.onPrimary ? Qaterial.Style.primaryColor : Qaterial.Style.backgroundColor
  property double radius: 0

  background: Rectangle
  {
    id: _back
    color: control.color
    radius: control.radius
    layer.enabled: control.enabled && control.elevation > 0
    layer.effect: Qaterial.ElevationEffect { elevation: control.elevation } // ElevationEffect
  } // Rectangle
} // Pane
