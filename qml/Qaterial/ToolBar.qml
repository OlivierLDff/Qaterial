/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls

// Qaterial
import Qaterial as Qaterial

T.ToolBar
{
  id: _control

  property double elevation: Qaterial.Style.toolbar.elevation

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    contentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    contentHeight + topPadding + bottomPadding)

  spacing: Qaterial.Style.card.horizontalPadding

  property color backgroundColor: Qaterial.Style.primaryColor

  background: Rectangle
  {
    implicitHeight: Qaterial.Style.toolbar.implicitHeight
    color: _control.backgroundColor

    layer.enabled: _control.elevation > 0
    layer.effect: Qaterial.ElevationEffect
    {
      elevation: _control.elevation
      fullWidth: true
    } // ElevationEffect
  } // Rectangle
} // ToolBar
