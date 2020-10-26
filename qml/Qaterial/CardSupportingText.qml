/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Controls 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

Item
{
  implicitHeight: _label.font.pixelSize * 3
  implicitWidth: 200
  property alias supportingText: _label.text

  Qaterial.Label
  {
    id: _label
    wrapMode: Text.WordWrap
    elide: Text.ElideRight
    maximumLineCount: 2
    verticalAlignment: Text.AlignVCenter
    textType: Qaterial.Style.TextType.ListSecText
    anchors.fill: parent
  } // Label
} // Item
