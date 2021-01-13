/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

Qaterial.MenuItem
{
  id: _control

  property alias indicatorSource: _indicatorIcon.source

  icon.width: radioIcon.width
  icon.height: radioIcon.height
  icon.color: radioIcon.color
  icon.source: radioIcon.source

  checkable: true

  Qaterial.ColorIcon
  {
    id: _indicatorIcon
    x: parent.width - width - Qaterial.Style.card.horizontalPadding
    anchors.verticalCenter: parent.verticalCenter
    color: _control.enabled ? (_control.colorReversed ? Qaterial.Style.primaryTextColorReversed() : Qaterial.Style
      .primaryTextColor()) : (_control.colorReversed ? Qaterial.Style.hintTextColorReversed() : Qaterial.Style
      .hintTextColor())
  } // ColorIcon
} // MenuItem
