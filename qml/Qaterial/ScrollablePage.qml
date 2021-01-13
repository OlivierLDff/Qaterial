/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

Qaterial.Page
{
  id: _page

  default property alias content: _pane.contentItem
  property alias pane: _pane

  Flickable
  {
    anchors.fill: parent
    contentHeight: _pane.implicitHeight + (Qt.inputMethod && Qt.inputMethod.visible ? (Qt.inputMethod
      .keyboardRectangle.height / Screen.devicePixelRatio) : 0)
    flickableDirection: Flickable.AutoFlickIfNeeded

    Qaterial.Pane
    {
      id: _pane
      width: parent.width
    } // Pane

    ScrollIndicator.vertical: Qaterial.ScrollIndicator {}
  } // Flickable
} // Page
