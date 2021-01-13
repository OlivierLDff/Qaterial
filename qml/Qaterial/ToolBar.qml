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
