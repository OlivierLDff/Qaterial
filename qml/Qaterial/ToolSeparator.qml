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

T.ToolSeparator
{
  id: _control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    implicitContentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    implicitContentHeight + topPadding + bottomPadding)

  horizontalPadding: vertical ? Qaterial.Style.toolButton.separatorLargePadding : Qaterial.Style.toolButton
    .separatorSmallPadding
  verticalPadding: vertical ? Qaterial.Style.toolButton.separatorSmallPadding : Qaterial.Style.toolButton
    .separatorLargePadding

  property bool highlighted: false

  property bool onPrimary: false
  property bool colorReversed: onPrimary && Qaterial.Style.shouldReverseForegroundOnPrimary

  property color foregroundColor: !enabled ? (colorReversed ? Qaterial.Style.disabledDividersColorReversed() :
      Qaterial.Style.disabledDividersColor()) : highlighted && accentColorAuthorized ? Qaterial.Style.accentColor :
    colorReversed ? Qaterial.Style.dividersColorReversed() : Qaterial.Style.dividersColor()

  property bool drawline: Qaterial.Style.debug.drawDebugButton

  Qaterial.DebugRectangle
  {
    anchors.fill: parent
    border.color: "pink"
    visible: _control.drawline
  } // DebugRectangle

  contentItem: Rectangle
  {
    implicitWidth: vertical ? 1 : Qaterial.Style.toolButton.separatorImplicitWidth
    implicitHeight: vertical ? Qaterial.Style.toolButton.separatorImplicitWidth : 1
    color: _control.foregroundColor
  } // Rectangle
} // ToolSeparator
