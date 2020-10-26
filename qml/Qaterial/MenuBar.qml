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

T.MenuBar
{
  id: _control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    contentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    contentHeight + topPadding + bottomPadding)

  delegate: Qaterial.MenuBarItem { onPrimary: _control.onPrimary;colorReversed: _control.colorReversed }

  contentItem: Row
  {
    spacing: _control.spacing
    Repeater
    {
      model: _control.contentModel
    } // Repeater
  } // Row

  property bool onPrimary: false
  property bool colorReversed: onPrimary && Qaterial.Style.shouldReverseForegroundOnPrimary

  property color backgroundColor: onPrimary ? Qaterial.Style.primaryColor : Qaterial.Style.dialogColor

  background: Rectangle
  {
    implicitHeight: Qaterial.Style.menu.implicitHeight
    color: _control.backgroundColor
  } // Rectangle
} // MenuBar
