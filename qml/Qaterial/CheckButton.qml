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
  id: root

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    implicitContentWidth + leftPadding + rightPadding + implicitIndicatorWidth)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    implicitContentHeight + topPadding + bottomPadding,
    implicitIndicatorHeight + topPadding + bottomPadding)

  spacing: Qaterial.Style.checkButton.spacing
  horizontalPadding: Qaterial.Style.checkButton.horizontalPadding
  verticalPadding: Qaterial.Style.checkButton.verticalPadding

  font: Qaterial.Style.textTheme.body2

  property bool onPrimary: false
  property bool colorReversed: onPrimary && Qaterial.Style.shouldReverseForegroundOnPrimary

  property bool drawline: Qaterial.Style.debug.drawDebugButton

  property alias elide: _label.elide

  Qaterial.DebugRectangle
  {
    anchors.fill: parent
    border.color: "pink"
    visible: root.drawline
  } // DebugRectangle

  indicator: Qaterial.CheckIndicator
  {
    x:
    {
      if(text)
        return root.mirrored ? (root.width - width - root.rightPadding) : root.leftPadding
      return root.leftPadding + (root.availableWidth - width) / 2
    }
    y: root.topPadding + (root.availableHeight - height) / 2
    control: root

    Qaterial.Ripple
    {
      x: (parent.width - width) / 2
      y: (parent.height - height) / 2
      width: Qaterial.Style.switchButton.rippleWidth
      height: Qaterial.Style.switchButton.rippleWidth

      z: -1
      anchor: root
      pressed: root.pressed
      active: root.down || root.visualFocus || root.hovered
      color: Qaterial.Style.rippleColor(root.checked ? Qaterial.Style.RippleBackground.AccentLight : Qaterial
        .Style.RippleBackground.Background)
    } // Ripple

    Qaterial.DebugRectangle
    {
      anchors.fill: parent
      border.color: "red"
      visible: root.drawline
    } // DebugRectangle
  } // CheckIndicator

  contentItem: Qaterial.Label
  {
    id: _label
    leftPadding: (root.indicator && !root.mirrored) ? root.indicator.width + root.spacing : 0
    rightPadding: (root.indicator && root.mirrored) ? root.indicator.width + root.spacing : 0

    onPrimary: root.onPrimary
    colorReversed: root.colorReversed
    font: root.font

    text: root.text
    enabled: root.enabled
    elide: !root.mirrored ? Text.ElideRight : Text.ElideLeft
    verticalAlignment: Text.AlignVCenter

    Qaterial.DebugRectangle
    {
      anchors.fill: parent
      border.color: "green"
      visible: root.drawline
    } // DebugRectangle
  } // Label
} // CheckBox
