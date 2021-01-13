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
  property int display: AbstractButton.TextOnly
  property double minWidth: Qaterial.Style.tabBar.minTabWidth
  property double maxWidth: Qaterial.Style.tabBar.maxTabWidth
  property int maxElement: 5
  implicitWidth: width

  leftPadding: !mirrored ? Qaterial.Style.tabBar.minLeftWidth : 0
  rightPadding: mirrored ? Qaterial.Style.tabBar.minLeftWidth : 0

  Repeater
  {
    id: _repeater
    delegate: Qaterial.TabButton
    {
      width: Math.max(_root.minWidth, Math.min(_root.width / _root.maxElement, _root.maxWidth))
      implicitWidth: width
      display: _root.display
      text: model.text ? model.text : ""
      icon.source: model.source ? model.source : ""
      onPrimary: _root.onPrimary
      enabled: _root.enabled
    } // TabButton
  } // Repeater
} // TabBar
