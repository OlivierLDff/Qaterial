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
  property bool hintText: false
  property bool useSmallFont: false
  implicitWidth: width

  Repeater
  {
    id: _repeater
    delegate: Qaterial.TabButton
    {
      elide: Text.ElideRight
      width: _root.width / model.count
      implicitWidth: width
      display: hintText ? (!checked ? AbstractButton.IconOnly : AbstractButton.TextUnderIcon) : _root.display
      text: model.text ? model.text : ""
      icon.source: model.source ? model.source : ""
      onPrimary: _root.onPrimary
      enabled: _root.enabled
      hintText: _root.hintText
      useSmallFont: _root.useSmallFont
    } // TabButton
  } // Repeater
} // TabBar
