/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

T.CheckBox
{
  id: _control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    implicitContentWidth + leftPadding + rightPadding + implicitIndicatorWidth)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    implicitContentHeight + topPadding + bottomPadding,
    implicitIndicatorHeight + topPadding + bottomPadding)

  spacing: Qaterial.Style.checkButton.spacing
  horizontalPadding: Qaterial.Style.checkButton.horizontalPadding
  verticalPadding: Qaterial.Style.checkButton.verticalPadding

  property bool onPrimary: false
  property bool colorReversed: onPrimary && Qaterial.Style.shouldReverseForegroundOnPrimary

  property bool drawline: Qaterial.Style.debug.drawDebugButton

  property alias elide: _label.elide
  property alias textType: _label.textType

  Qaterial.DebugRectangle
  {
    anchors.fill: parent
    border.color: "pink"
    visible: _control.drawline
  } // DebugRectangle

  indicator: Qaterial.CheckIndicator
  {
    x:
    {
      if(text)
        return _control.mirrored ? (_control.width - width - _control.rightPadding) : _control.leftPadding
      return _control.leftPadding + (_control.availableWidth - width) / 2
    }
    y: _control.topPadding + (_control.availableHeight - height) / 2
    control: _control

    Qaterial.Ripple
    {
      x: (parent.width - width) / 2
      y: (parent.height - height) / 2
      width: Qaterial.Style.switchButton.rippleWidth
      height: Qaterial.Style.switchButton.rippleWidth

      z: -1
      anchor: _control
      pressed: _control.pressed
      active: _control.down || _control.visualFocus || _control.hovered
      color: Qaterial.Style.rippleColor(_control.checked ? Qaterial.Style.RippleBackground.AccentLight : Qaterial
        .Style.RippleBackground.Background)
    } // Ripple

    Qaterial.DebugRectangle
    {
      anchors.fill: parent
      border.color: "red"
      visible: _control.drawline
    } // DebugRectangle
  } // CheckIndicator

  contentItem: Qaterial.Label
  {
    id: _label
    leftPadding: (_control.indicator && !_control.mirrored) ? _control.indicator.width + _control.spacing : 0
    rightPadding: (_control.indicator && _control.mirrored) ? _control.indicator.width + _control.spacing : 0

    onPrimary: _control.onPrimary
    colorReversed: _control.colorReversed

    text: _control.text
    enabled: _control.enabled
    elide: !_control.mirrored ? Text.ElideRight : Text.ElideLeft
    verticalAlignment: Text.AlignVCenter

    Qaterial.DebugRectangle
    {
      anchors.fill: parent
      border.color: "green"
      visible: _control.drawline
    } // DebugRectangle
  } // Label
} // CheckBox
