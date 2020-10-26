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

T.MenuSeparator
{
  id: _control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    implicitContentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    implicitContentHeight + topPadding + bottomPadding)

  verticalPadding: Qaterial.Style.menu.separatorHSmallPadding
  rightPadding: !mirrored ? Qaterial.Style.menu.separatorWSmallPadding : Qaterial.Style.menu.separatorWLargePadding
  leftPadding: mirrored ? Qaterial.Style.menu.separatorWSmallPadding : Qaterial.Style.menu.separatorWLargePadding

  property bool highlighted: false

  property bool onPrimary: false
  property bool colorReversed: onPrimary && Qaterial.Style.shouldReverseForegroundOnPrimary
  property bool accentColorAuthorized: onPrimary && Qaterial.Style.preferAccentOnPrimary

  property color foregroundColor: !enabled ? (colorReversed ? Qaterial.Style.disabledDividersColorReversed() :
      Qaterial.Style.disabledDividersColor()) : highlighted && accentColorAuthorized ? Qaterial.Style.accentColor :
    colorReversed ? Qaterial.Style.dividersColorReversed() : Qaterial.Style.dividersColor()

  property bool drawline: Qaterial.Style.debug.drawDebugButton

  property double separatorImplicitWidth: Qaterial.Style.menu.separatorImplicitWidth

  Qaterial.DebugRectangle
  {
    anchors.fill: parent
    border.color: "pink"
    visible: _control.drawline
  } // DebugRectangle

  contentItem: Rectangle
  {
    implicitWidth: _control.separatorImplicitWidth
    implicitHeight: 1
    color: _control.foregroundColor

    Qaterial.DebugRectangle
    {
      anchors.fill: parent
      border.color: "red"
      visible: _control.drawline
    } // DebugRectangle
  } // Rectangle
} // MenuSeparator
