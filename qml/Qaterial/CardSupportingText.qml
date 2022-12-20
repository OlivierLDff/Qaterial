/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick
import QtQuick.Controls

// Qaterial
import Qaterial as Qaterial

Item
{
  implicitHeight: _label.font.pixelSize * 3
  implicitWidth: 200
  property alias supportingText: _label.text

  Qaterial.LabelBody1
  {
    id: _label
    wrapMode: Text.WordWrap
    elide: Text.ElideRight
    maximumLineCount: 2
    verticalAlignment: Text.AlignVCenter
    anchors.fill: parent
  } // Label
} // Item
