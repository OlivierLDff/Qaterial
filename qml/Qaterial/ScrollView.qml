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

T.ScrollView
{
  id: _control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    contentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    contentHeight + topPadding + bottomPadding)

  ScrollBar.vertical: Qaterial.ScrollBar
  {
    parent: _control
    x: _control.mirrored ? 0 : _control.width - width
    y: _control.topPadding
    height: _control.availableHeight
    active: _control.ScrollBar.horizontal.active
  } // ScrollBar

  ScrollBar.horizontal: Qaterial.ScrollBar
  {
    parent: _control
    x: _control.leftPadding
    y: _control.height - height
    width: _control.availableWidth
    active: _control.ScrollBar.vertical.active
  } // ScrollBar
} // ScrollView
