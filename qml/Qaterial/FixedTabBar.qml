/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Controls 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

Qaterial.TabBar
{
  id: _root
  property alias model: _repeater.model
  property alias button: _repeater.delegate
  property int display: AbstractButton.TextUnderIcon
  implicitWidth: width

  Repeater
  {
    id: _repeater
    delegate: Qaterial.TabButton
    {
      width: implicitWidth
      implicitWidth: _root.width / model.count
      display: _root.display
      text: model.text ? model.text : ""
      icon.source: model.source ? model.source : ""
      onPrimary: _root.onPrimary
      spacing: _root.spacing
      enabled: _root.enabled
    } // TabButton
  } // Repeater
} // TabBar
