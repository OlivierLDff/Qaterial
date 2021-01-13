/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12

// Qaterial
import Qaterial 1.0 as Qaterial

Qaterial.FabButton
{
  id: _control
  flat: true
  elevation: 0
  highlighted: checked
  type: Qaterial.Style.FabType.Default

  readonly property double __inset: rippleClip ? Qaterial.Style.fab.flatInset : Qaterial.Style.fab.flatInsetNoClip

  topInset: __inset
  bottomInset: __inset
  leftInset: __inset
  rightInset: __inset

  backgroundColor: !enabled ? "transparent" : highlighted ? Qaterial.Style.buttonAccentColor : Qaterial.Style
    .disabledDividersColor()
  property color borderColor: "transparent"
  property int borderWidth: _control.outlined ? 1 : 0
  property bool outlined: false

  foregroundColor: !enabled ? Qaterial.Style.disabledTextColor() : highlighted ? (Qaterial.Style
      .shouldReverseForegroundOnAccent ? Qaterial.Style.primaryTextColorReversed() : Qaterial.Style.primaryTextColor()
    ) : Qaterial.Style.theme === Qaterial.Style.Theme.Light ? Qaterial.Style.primaryTextColor() : Qaterial.Style
    .secondaryTextColor()
  enabledScale: false

  property bool rippleClip: true

  property double backgroundImplicitWidth: type === Qaterial.Style.FabType.Extended ? Qaterial.Style.fab
    .minWidthExtended : type === Qaterial.Style.FabType.Mini ? Qaterial.Style.fab.minWidthMini : Qaterial.Style.fab
    .minWidth
  property double backgroundImplicitHeight: type === Qaterial.Style.FabType.Extended ? Qaterial.Style.fab
    .minHeightExtended : type === Qaterial.Style.FabType.Mini ? Qaterial.Style.fab.minWidthMini : Qaterial.Style.fab
    .minWidth
  property double backgroundScale: 1.0

  background: Rectangle
  {
    implicitWidth: _control.backgroundImplicitWidth
    implicitHeight: _control.backgroundImplicitHeight
    radius: _control.radius
    color: _control.backgroundColor
    scale: _control.backgroundScale

    border.width: _control.borderWidth
    border.color: _control.borderColor

    Behavior on implicitWidth
    {
      NumberAnimation
      {
        easing.type: Easing.InOutQuad;
        duration: 100
      }
    }
    Behavior on implicitHeight
    {
      NumberAnimation
      {
        easing.type: Easing.InOutQuad;
        duration: 100
      }
    }

    Qaterial.DebugRectangle
    {
      anchors.fill: parent
      border.color: "aquamarine"
      visible: _control.drawline
    } // DebugRectangle

    Qaterial.Ripple
    {
      id: _ripple
      property bool isActive: _control.down || _control.visualFocus || _control.hovered
      width: rippleClip ? parent.width : parent.implicitWidth
      height: rippleClip ? parent.height : parent.implicitHeight
      anchors.centerIn: parent
      pressed: _control.pressed
      anchor: _control
      active: isActive
      color: _control.rippleColor
      layer.enabled: _control.rippleClip
      layer.effect: OpacityMask
      {
        maskSource: Rectangle
        {
          width: _ripple.width
          height: _ripple.height
          radius: _control.radius
        } // Rectangle
      } // OpacityMask
    } // Ripple
  } // Rectangle
} // FabButton
