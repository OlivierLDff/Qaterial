/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick
import QtQuick.Controls

// Qaterial
import Qaterial as Qaterial

Qaterial.TabBar
{
  id: _root
  property alias model: _repeater.model
  property int display: AbstractButton.TextBesideIcon
  width: implicitWidth

  Repeater
  {
    id: _repeater
    delegate: Qaterial.TabButton
    {
      display: _root.display
      text: model.text ? model.text : ""
      icon.source: model.source ? model.source : ""
      enabled: _root.enabled
    } // TabButton
  } // Repeater
} // TabBar
