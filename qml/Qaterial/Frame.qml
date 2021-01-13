/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Templates 2.12 as T

// Qaterial
import Qaterial 1.0 as Qaterial

T.Frame
{
  id: _control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    contentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    contentHeight + topPadding + bottomPadding)

  horizontalPadding: Qaterial.Style.card.horizontalPadding
  verticalPadding: Qaterial.Style.card.verticalPadding

  property bool onPrimary: false
  property bool colorReversed: onPrimary && Qaterial.Style.shouldReverseForegroundOnPrimary

  property color color: onPrimary ? Qaterial.Style.primaryColor : Qaterial.Style.backgroundColor
  property color borderColor: enabled ? Qaterial.Style.dividersColor() : Qaterial.Style.disabledDividersColor()
  property alias radius: _rect.radius

  property double elevation

  background: Rectangle
  {
    id: _rect
    implicitWidth: 200
    radius: Qaterial.Style.card.radius
    color: _control.elevation > 0 ? _control.color : "transparent"
    border.color: _control.borderColor
    border.width: 1

    layer.enabled: _control.enabled && _control.elevation > 0
    layer.effect: Qaterial.ElevationEffect
    {
      elevation: _control.elevation
    } // ElevationEffect
  } // Rectangle
} // Frame
